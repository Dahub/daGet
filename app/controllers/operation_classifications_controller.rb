class OperationClassificationsController < ApplicationController

	before_filter :check_if_logged

	def index
		@operationClassifications = OperationClassification.where(user_id: session[:current_user_id])
	end

	def destroy
		@oc = OperationClassification.find(params[:id])
		@oc.destroy		
		redirect_to action: 'index'	
	end
	
	def add_operation_classification
		OperationClassification.create(wording: params[:oc][:wording], user_id: session[:current_user_id])
		redirect_to action: 'index'	
	end
end