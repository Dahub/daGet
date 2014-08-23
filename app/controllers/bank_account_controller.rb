class BankAccountController < ApplicationController

	before_filter :check_if_logged, :only => [:index, :logout]

	def index
		@bankAccount = BankAccount.allByLoggedUser(session[:current_user_id])
	end
	
	def create
		@bankAccount = BankAccount.new
	end
end