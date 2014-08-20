class HomeController < ApplicationController
	
	# permet de vérifier que l'utilisateur est connecté, avec les liste des actions concernées
	before_filter :check_if_logged, :only => [:index, :logout]

	def login
		if session[:current_user_id] != nil
			redirect_to action: 'index'
		end	
		if request.post?
			#@user = User.where(:username=>params[:user][:username]).where(:password=>Digest::SHA2.hexdigest(params[:user][:password])).first	
			@user = User.get_by_login_and_password(params[:user][:username], params[:user][:password])
			if @user != nil
				session[:current_user_id] = @user.id
				redirect_to action: 'index'
			end
		else	
			# print Rails.logger.info("requete GET")
			@user = User.new
		end
	end

	def index
		
	end
  
	def logout
		session[:current_user_id] = nil
		redirect_to action: 'login'
	end
end
