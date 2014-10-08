class HomeController < ApplicationController
	
	# permet de vérifier que l'utilisateur est connecté, avec les liste des actions concernées
	before_filter :check_if_logged, :only => [:index, :logout]

	def login
		if session[:current_user_id] != nil
			redirect_to action: 'index'
		end	
		if request.post?
			@user = User.get_by_login_and_password(params[:user][:username], params[:user][:password])
			if @user != nil
				session[:current_user_id] = @user.id
				redirect_to action: 'index'
			end
		else				
			@user = User.new
		end
	end

	def index
		@bankAccount = BankAccount.allByLoggedUser(session[:current_user_id])
	end
  
	def logout
		session[:current_user_id] = nil
		redirect_to action: 'login'
	end
end
