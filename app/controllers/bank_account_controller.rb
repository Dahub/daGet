class BankAccountController < ApplicationController

	before_filter :check_if_logged, :only => [:index, :logout]

	def index
		@bankAccount = BankAccount.allByLoggedUser(session[:current_user_id])
	end
	
	def new		

	end
	
	def create
		#render plain: params[:bankAccount].inspect
		#@my_bank_account = BankAccount.new(bankAccount_params)
		#@my_bank_account.user = User.find(session[:current_user_id])
		#@my_bank_account.save()
		
		BankAccount.addBankAccount(bankAccount_params, session[:current_user_id])
		
		redirect_to action: 'index'
	end	
	
	private
		def bankAccount_params
			params.require(:bankAccount).permit(:name, :initial_amount, :devise_id, :bank_account_type_id)
		end
end