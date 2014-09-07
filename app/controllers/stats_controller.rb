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
	
end