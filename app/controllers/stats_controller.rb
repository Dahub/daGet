class StatsController < ApplicationController
	before_filter :check_if_logged

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
			@my_operations = @my_bank_account.operations.where('date_operation >= ?', (Date.today << 11).beginning_of_month).
									where('date_operation < ?', Date.today.end_of_month).
									where('operation_classification_id = ?', params[:operation_classification_id]).output.
									group_by {|o| o.date_operation.beginning_of_month}
			
			@my_array = Array.new
			
			@my_operations.keys.sort.each do |month|
				@to_push = Array.new
				@to_push.push(month.utc.to_i)
				@to_push.push(@my_operations[month].collect(&:amount).sum)
				@my_array.push(@to_push)
			end			
			
			render :json =>  @my_array
							
		end
	end
	
end