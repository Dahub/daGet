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
		@my_operation = Operation.find(operation_id)
		if(@my_operation.movement == 'input')
			@my_operation.bank_account.final_amount -= @my_operation.amount
		else
			@my_operation.bank_account.final_amount += @my_operation.amount
		end
		@my_operation.bank_account.save()	
		@my_operation.destroy
	end
	
	def rebuild_final_amount()
		amount = self.initial_amount		
		amount = amount + self.operations.input.sum(:amount)		
		amount = amount - self.operations.output.sum(:amount)	
		self.final_amount = amount
	end
	
end