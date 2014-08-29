class BankAccountsController < ApplicationController

	before_filter :check_if_logged, :only => [:index, :logout]	
	
	def show
		@bankAccount = BankAccount.find(params[:id])
	end
	
	def index
		@bankAccount = BankAccount.allByLoggedUser(session[:current_user_id])
	end
	
	def new
		@bankAccount = BankAccount.new(account_owner: User.find(session[:current_user_id]).fullname)
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
	 	@bankAccount = BankAccount.find(params[:id])
		if(@bankAccount.update(bankAccount_params))
			@bankAccount.updateBankAccount()
			redirect_to action: 'index'	
		else
			render 'edit'
		end
	end
	
	def create		
		@bankAccount = BankAccount.new(bankAccount_params)
		if(@bankAccount.valid?)
			@bankAccount.addBankAccount(session[:current_user_id])	
			redirect_to action: 'index'		
		else			
			render 'new'
		end
	end	
	
	def add_operation
		#render plain: params[:operation].inspect
		@my_operation = Operation.new(operation_params)
		if(@my_operation.valid?)		
			BankAccount.addOperation(@my_operation)		
		end
		@bankAccount = BankAccount.find(@my_operation.bank_account_id)
		render 'show'
	end
	
	def delete_operation		
		BankAccount.removeOperation(params[:id_operation])		
		redirect_to action: 'show', :id => params[:id_bank_account]
	end
	
	private
		def bankAccount_params
			params.require(:bank_account).permit(:name, :initial_amount, :devise_id, :bank_account_type_id, :account_number, :account_owner)
		end
		
		def operation_params
			params.require(:operation).permit(:bank_account_id, :date_operation, :wording, :operation_classification_id, :amount, :movement)
		end
end