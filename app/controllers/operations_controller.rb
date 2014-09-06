class OperationsController < ApplicationController
	def check
		if(check_if_user_own_operation(params[:id]))
			my_operation = Operation.find(params[:id])
			my_operation.update(operation_valid: "ok")
			redirect_to controller: 'bank_accounts', action: 'show', :id => params[:id_bank_account]
		end
	end
	
	def uncheck
		if(check_if_user_own_operation(params[:id]))
			my_operation = Operation.find(params[:id])
			my_operation.update(operation_valid: "not_ok")
			redirect_to controller: 'bank_accounts', action: 'show', :id => params[:id_bank_account]
		end
	end
end