class BankAccount < ActiveRecord::Base
	belongs_to :user,
		inverse_of: :bankAccounts
	
	belongs_to :devise
	belongs_to :bank_account_type
	has_many :operations
	has_many :transfers
	
	validates 	:name, :presence => { message: "Le nom du compte est obligatoire" }
	validates	:initial_amount, 
				:presence => { message: "Le montant initial est obligatoire" }, 
				:numericality => { message: "Le montant doit être numérique" }
	validates	:bank_account_type_id, presence: true
	validates	:devise_id, presence: true
	  
	def self.allByLoggedUser(idUser)
		User.find(idUser).bankAccounts.all
	end 
  
	def smart_final_amount()
		"#{final_amount} #{devise.symbol}"
	end 
	
	def current_final_amout()
	  #get all actives operations (0 == output, 1 == input)
	  to_return = final_amount - Operation.where(bank_account_id: id).where(movement: 0).where(operation_valid:'not_ok').sum(:amount)
	  to_return + Operation.where(bank_account_id: id).where(movement: 1).where(operation_valid:'not_ok').sum(:amount)
	end
	
	def addBankAccount(my_user_id)
		self.user_id = my_user_id
		rebuild_final_amount()
		save()
	end	
	
	def updateBankAccount()
		rebuild_final_amount()
		save()
	end	
	
	def self.addOperation(my_operation)
		my_operation.save
		if(my_operation.movement == 'input')
			my_operation.bank_account.final_amount += my_operation.amount
		else
			my_operation.bank_account.final_amount -= my_operation.amount
		end
		my_operation.bank_account.save()	
	end
	
	def self.removeOperation(operation_id)
		my_operation = Operation.find(operation_id)		
		if(my_operation.movement_type == 'transfer')
			removeTransferOperation(my_operation)
		else
			removeNormalOperation(my_operation)
		end			
	end
	
	def self.updateOperation(my_operation, op_params)
		if(my_operation.movement_type == 'transfer')
			updateTransferOperation(my_operation, op_params)
		else
			updateNormalOperation(my_operation, op_params)
		end			
	end
	
	def rebuild_final_amount()
		amount = self.initial_amount		
		amount = amount + self.operations.input.sum(:amount)		
		amount = amount - self.operations.output.sum(:amount)	
		self.final_amount = amount
	end	
	
	private 
		def self.removeNormalOperation(my_operation)
			updateBankAccountAmount(my_operation)
			my_operation.destroy
		end
		
		def self.removeTransferOperation(my_operation)
			my_transfer = Transfer.where("to_operation_id = ? or from_operation_id = ?", my_operation.id, my_operation.id).first
			removeNormalOperation(my_transfer.to_operation)
			removeNormalOperation(my_transfer.from_operation)
			my_transfer.destroy
		end
		
		def self.updateNormalOperation(my_operation, op_params)
			removeNormalOperation(my_operation)
			addOperation(Operation.new(
					bank_account_id: op_params[:bank_account_id], 
					date_operation: op_params[:date_operation], 
					wording: op_params[:wording], 
					operation_classification_id: op_params[:operation_classification_id], 
					amount: op_params[:amount], 
					movement: op_params[:movement], 
					movement_type: op_params[:movement_type]				
				))
		end
		
		def self.updateTransferOperation(my_operation, op_params)
			my_transfer = Transfer.where("to_operation_id = ? or from_operation_id = ?", my_operation.id, my_operation.id).first
			updateNormalOperation(my_transfer.to_operation, op_params)
			updateNormalOperation(my_transfer.from_operation, op_params)		
		end
		
		def self.updateBankAccountAmount(my_operation)
			if(my_operation.movement == 'input')
				my_operation.bank_account.final_amount -= my_operation.amount
			else
				my_operation.bank_account.final_amount += my_operation.amount
			end
			my_operation.bank_account.save()
		end
end