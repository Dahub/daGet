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
end
