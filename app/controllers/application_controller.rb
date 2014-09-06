class ApplicationController < ActionController::Base
	# Prevent CSRF attacks by raising an exception.
	# For APIs, you may want to use :null_session instead.
	protect_from_forgery with: :exception
  
	def check_if_logged
		if session[:current_user_id] != nil
			return true
		else
			redirect_to(:controller => 'home', :action => 'login')
			return false
		end
	end
  
	def check_if_user_own_bank_account(bankAccount)
		if(bankAccount.user_id != session[:current_user_id])
			redirect_to_forbiden_page
			return false
		end
		return true
	end
	
	def check_if_user_own_operation(operation_id)
		if(Operation.find(operation_id).bank_account.user_id != session[:current_user_id])
			redirect_to_forbiden_page
			return false
		end
		return true
	end
	
	private 
		def redirect_to_forbiden_page
			redirect_to action: 'index', controller: 'home'
		end
end
