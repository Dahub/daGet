class Operation < ActiveRecord::Base
	belongs_to :operation_classification
	belongs_to :bank_account
	belongs_to :operation_type
	
	enum movement: { output: 0, input: 1 }
end