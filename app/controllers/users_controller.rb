class UsersController < ApplicationController
	before_filter :check_if_logged, :except => [:new, :create]
	
	def new
		@user = User.new
	end
	
	def edit
		@user = User.find(params[:id])
	end
	
	def create
		@user = User.new(user_params)		
		if(@user.valid?)
			User.add_user(@user)
			session[:current_user_id] = @user.id
			redirect_to action: "index", controller: "home"
		else			
			render "new"
		end
	end
	
	def update
		@user = User.find(session[:current_user_id])
		if(@user.update(fullname: params[:user][:fullname], email: params[:user][:email]))
			redirect_to action: "index", controller: "home"
		else
			render "edit"
		end
		#render plain: params[:user][:fullname]
	end
	
	private
	
		def user_params
			params.require(:user).permit(:id, :fullname, :username, :email, :password, :password_confirmation)
		end
end