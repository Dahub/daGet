class BankAccount < ActiveRecord::Base
  belongs_to :user
  belongs_to :devise
  
  def self.allByLoggedUser(idUser)
	User.find(idUser).bankAccounts.all
  end 
  
  def smart_final_amount
	"#{final_amount} #{devise.symbol}"
  end
end