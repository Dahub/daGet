class Transfer < ActiveRecord::Base
	belongs_to :from_bank_account, :class_name => 'BankAccount', :foreign_key => 'from_bank_account_id'
	belongs_to :to_bank_account, :class_name => 'BankAccount', :foreign_key => 'to_bank_account_id'
	belongs_to :from_operation, :class_name => 'Operation', :foreign_key => 'from_operation_id'
	belongs_to :to_operation, :class_name => 'Operation', :foreign_key => 'to_operation_id'
	
	def self.add_transfer(my_transfer)
		# create from operation
		@from_operation = Operation.new(	bank_account_id: my_transfer.from_bank_account_id,
													movement: 0,
													movement_type: 1,
													wording: my_transfer.wording,
													amount: my_transfer.amount,
													date_operation: my_transfer.date_transfer)
		@to_operation = Operation.new(	bank_account_id: my_transfer.to_bank_account_id,
													movement: 1,
													movement_type: 1,
													wording: my_transfer.wording,
													amount: my_transfer.amount,
													date_operation: my_transfer.date_transfer)
		
		BankAccount.addOperation(@from_operation)
		BankAccount.addOperation(@to_operation)
													
		my_transfer.from_operation = @from_operation
		my_transfer.to_operation = @to_operation
		my_transfer.save
	end
end