class Transfer < ActiveRecord::Base
	belongs_to :from_bank_account, :class_name => 'BankAccount', :foreign_key => 'from_bank_account_id'
	belongs_to :to_bank_account, :class_name => 'BankAccount', :foreign_key => 'to_bank_account_id'
end