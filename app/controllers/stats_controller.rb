class StatsController < ApplicationController
	before_filter :check_if_logged

	def input_output_data
		@my_bank_account = BankAccount.find(params[:bank_account_id])
		if(check_if_user_own_bank_account(@my_bank_account))
			render :json => {
								:output => 	@my_bank_account.operations.where('date_operation >= ?', Date.parse(params[:month]).beginning_of_month).
											where('date_operation < ?', (Date.parse(params[:month]) >> 1).beginning_of_month).output.
											joins(:operation_classification).sum(:amount),
								:input => 	@my_bank_account.operations.where('date_operation >= ?', Date.parse(params[:month]).beginning_of_month).
											where('date_operation < ?', (Date.parse(params[:month]) >> 1).beginning_of_month).input.
											joins(:operation_classification).sum(:amount)	
							}			
		end
	end
	
	def evolution_solde
  end
  
  def evolution_solde_data
    @my_bank_account = BankAccount.find(params[:bank_account_id])
    if(check_if_user_own_bank_account(@my_bank_account))
      @my_array = Array.new  
      @my_array_prev = Array.new  
      @current_amount = @my_bank_account.current_final_amout
      @end_of_month = Date.today.end_of_month
      (0..@end_of_month.day).each do |i|
        
        @to_push = Array.new
        @to_push_prev = Array.new
        @to_push.push(@end_of_month.day - i)
        @to_push_prev.push(@end_of_month.day - i)
        
        #enlever toutes les opérations closes des jours suivants        
        @my_output_sum = @current_amount + @my_bank_account.operations.where('date_operation > ?', @end_of_month - i.day).where(operation_valid:1).where(movement:0).sum(:amount)
        @my_output_sum = @my_output_sum - @my_bank_account.operations.where('date_operation > ?', @end_of_month - i.day).where(operation_valid:1).where(movement:1).sum(:amount)
        @to_push.push(@my_output_sum)        
        @my_array.push(@to_push)    
        
        #seconde série, toutes opérations confondues
        @my_output_sum = @my_bank_account.final_amount + @my_bank_account.operations.where('date_operation > ?', @end_of_month - i.day).where(movement:0).sum(:amount)   
        @my_output_sum = @my_output_sum - @my_bank_account.operations.where('date_operation > ?', @end_of_month - i.day).where(movement:1).sum(:amount) 
        @to_push_prev.push(@my_output_sum)
        @my_array_prev.push(@to_push_prev)
      end       
        
      render :json => {
                :result =>  @my_array,
                :result_prev => @my_array_prev
              }     
    end  
  end
	
	def operation_distribution
	end
	
	def operation_distribution_data		
		@my_bank_account = BankAccount.find(params[:bank_account_id])
		if(check_if_user_own_bank_account(@my_bank_account))
			render :json => {
								:output => 	if(params[:outputs] == "true")
												@my_bank_account.operations.where('date_operation >= ?', Date.parse(params[:startDate])).
												where('date_operation < ?', Date.parse(params[:endDate])).output.
												joins(:operation_classification).group('operation_classifications.wording').sum(:amount)
											else nil
											end	,
								:input => 	if(params[:inputs] == "true")
												@my_bank_account.operations.where('date_operation >= ?', Date.parse(params[:startDate])).
												where('date_operation < ?', Date.parse(params[:endDate]))
												.input.joins(:operation_classification).group('operation_classifications.wording').sum(:amount)
											else nil
											end
							}			
		end
	end
	
	def evolution_poste
	end
	
	def evolution_poste_data
		@my_bank_account = BankAccount.find(params[:bank_account_id])
		if(check_if_user_own_bank_account(@my_bank_account))
			@my_output_operations = @my_bank_account.operations.where('date_operation >= ?', (Date.today << 11).beginning_of_month).
									where('date_operation < ?', Date.today.end_of_month).
									where('operation_classification_id = ?', params[:operation_classification_id]).output.
									group_by {|o| o.date_operation.beginning_of_month.to_date.to_time.utc.to_i}
									
			@my_input_operations = @my_bank_account.operations.where('date_operation >= ?', (Date.today << 11).beginning_of_month).
						where('date_operation < ?', Date.today.end_of_month).
						where('operation_classification_id = ?', params[:operation_classification_id]).input.
						group_by {|o| o.date_operation.beginning_of_month.to_date.to_time.utc.to_i}
			
			@my_input_array = Array.new
			@my_output_array = Array.new		

			i = 0 
			until i == 12
				@my_date = (Date.today << i).beginning_of_month.to_date.to_time.utc.to_i			
				
				@my_input_sum = 0
				@my_output_sum = 0
				if @my_input_operations[@my_date] != nil
					@my_input_sum = -1 * @my_input_operations[@my_date].collect(&:amount).sum
				end
				if @my_output_operations[@my_date] != nil
					@my_output_sum = @my_output_operations[@my_date].collect(&:amount).sum
				end
							
				@to_push = Array.new
				@to_push.push(@my_date)
				@to_push.push(@my_output_sum)
				@my_output_array.push(@to_push)	
							
				@to_push = Array.new
				@to_push.push(@my_date)	
				@to_push.push(@my_input_sum)
				@my_input_array.push(@to_push)
				
				i += 1 
			end 			
				
			render :json => {
								:output => 	@my_output_array,
								:input => 	@my_input_array
							}		
							
		end
	end

end
