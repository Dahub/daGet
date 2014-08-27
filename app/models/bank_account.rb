class BankAccount < ActiveRecord::Base
	belongs_to :user
	belongs_to :devise
	belongs_to :bank_account_type
	has_many :operations
  
	def self.allByLoggedUser(idUser)
		User.find(idUser).bankAccounts.all
	end 
  
	def smart_final_amount()
		"#{final_amount} #{devise.symbol}"
	end 
  
	def self.addBankAccount(params, user_id)
		@my_bank_account = BankAccount.new(params)
		@my_bank_account.user = User.find(user_id)
		@my_bank_account.rebuild_final_amount()
		@my_bank_account.save()
	end 
	
	def self.updateBankAccount(params, id)
		@my_bank_account = BankAccount.find(id)		
		@my_bank_account.update(params)
		@my_bank_account.rebuild_final_amount()
		@my_bank_account.save()
	end
	
	def rebuild_final_amount()
		amount = self.initial_amount		
		amount = amount + self.operations.input.sum(:amount)		
		amount = amount - self.operations.output.sum(:amount)	
		self.final_amount = amount
	end
	
end