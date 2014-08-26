class BankAccountsController < ApplicationController

	before_filter :check_if_logged, :only => [:index, :logout]	
	
	def show
		@bankAccount = BankAccount.find(params[:id])
	end
	
	def index
		@bankAccount = BankAccount.allByLoggedUser(session[:current_user_id])
	end
	
	def new
		@bankAccount = BankAccount.new
	end
	
	def edit
		@bankAccount = BankAccount.find(params[:id])
	end
	
	def destroy
		@bankAccount = BankAccount.find(params[:id])
		@bankAccount.destroy
		
		redirect_to action: 'index'	
	end
	
	def update
		BankAccount.updateBankAccount(bankAccount_params, params[:id])		
	 	redirect_to action: 'index'	
	end
	
	def create
		#render plain: params[:bankAccount].inspect
		BankAccount.addBankAccount(bankAccount_params, session[:current_user_id])		
		redirect_to action: 'index'
	end	
	
	private
		def bankAccount_params
			params.require(:bankAccount).permit(:name, :initial_amount, :devise_id, :bank_account_type_id)
		end
end