class BankAccountsController < ApplicationController

	before_filter :check_if_logged
	skip_before_filter :verify_authenticity_token, :only => [:define_date]
	
	def show
		@bankAccount = BankAccount.find(params[:id])		
		
		if(check_if_user_own_bank_account(@bankAccount))
		
			if(session[:begin_date] == nil)
				session[:begin_date] = Date.today.beginning_of_month
			end
			
			if(session[:end_date] == nil)
				session[:end_date] = (Date.today >> 1).beginning_of_month			
			end
			return @bankAccount
		
		end
	end
	
	def index
		@bankAccount = BankAccount.allByLoggedUser(session[:current_user_id])
	end
	
	def new
		@bankAccount = BankAccount.new(account_owner: User.find(session[:current_user_id]).fullname)
	end
	
	def edit
		@bankAccount = BankAccount.find(params[:id])
		if(check_if_user_own_bank_account(@bankAccount))
			return @bankAccount
		end
	end
	
	def destroy
		@bankAccount = BankAccount.find(params[:id])
		if(check_if_user_own_bank_account(@bankAccount))
			@bankAccount.destroy		
			redirect_to action: 'index'	
		end
	end
	
	def update		
	 	@bankAccount = BankAccount.find(params[:id])
		if(check_if_user_own_bank_account(@bankAccount))
		
			if(@bankAccount.update(bankAccount_params))
				@bankAccount.updateBankAccount()
				redirect_to action: 'index'	
			else
				render 'edit'
			end
		
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
		if(check_if_user_own_operation(params[:id_operation]))
			BankAccount.removeOperation(params[:id_operation])		
			redirect_to action: 'show', :id => params[:id_bank_account]
		end
	end
	
	def update_operation
		if(check_if_user_own_operation(params[:operation][:id]))
			my_operation = Operation.find(params[:operation][:id])		
			BankAccount.updateOperation(my_operation, operation_params)
			redirect_to action: 'show', :id => my_operation.bank_account_id
		end
	end
	
	def define_date
		new_date = Date.new(params[:define_date_year].to_i, params[:define_date_month].to_i, 1)
		
		session[:begin_date] = new_date.beginning_of_month
		session[:end_date] = (new_date >> 1).beginning_of_month	
		@bankAccount = BankAccount.find(params[:id])
		render 'show'
	end
	
	private
		def bankAccount_params
			params.require(:bank_account).permit(:name, :initial_amount, :devise_id, :bank_account_type_id, :account_number, :account_owner)
		end
		
		def operation_params
			params.require(:operation).permit(:bank_account_id, :date_operation, :wording, :operation_classification_id, :amount, :movement, :movement_type)
		end
end