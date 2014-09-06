class TransfersController < ApplicationController
	before_filter :check_if_logged
	
	def new
		@transfer = Transfer.new
	end
	
	def create
		@transfer = Transfer.new(transfer_params)
		if(@transfer.valid?)
			Transfer.add_transfer(@transfer)
		redirect_to action: 'index', controller: 'home'
		else
			render "new"
		end		
	end
	
	private
		def transfer_params
			params.require(:transfer).permit(:wording, :amount, :to_bank_account_id, :from_bank_account_id, :date_transfer, :operation_classification_id)
		end
end