class BankAccount < ActiveRecord::Base
	belongs_to :user
	belongs_to :devise
	belongs_to :bank_account_type
  
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
  
	def rebuild_final_amount()
		self.final_amount = self.initial_amount
	end
	
end