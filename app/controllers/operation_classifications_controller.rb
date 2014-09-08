class OperationClassificationsController < ApplicationController

	before_filter :check_if_logged

	def index
		@oc = OperationClassification.new
		@operationClassifications = OperationClassification.where(user_id: session[:current_user_id])
	end

	def edit
		@oc = OperationClassification.find(params[:id])		
	end
	
	def update
		#render plain: params.inspect
		@oc = OperationClassification.find(params[:id])
		if(@oc.update(wording: params[:operation_classification][:wording]))			
			redirect_to action: 'index'
		else
			render 'edit'
		end
	end
	
	def destroy
		@oc = OperationClassification.find(params[:id])
		@oc.destroy		
		redirect_to action: 'index'	
	end
	
	def add_operation_classification
		#render plain: params.inspect	
		@oc = OperationClassification.new(wording: params[:operation_classification][:wording], user_id: session[:current_user_id])
		if(@oc.valid?)
			@oc.save
			redirect_to action: 'index'	
		else	
			@operationClassifications = OperationClassification.where(user_id: session[:current_user_id])
			render 'index'
		end

	end
end