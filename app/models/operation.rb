class Operation < ActiveRecord::Base
	belongs_to :operation_classification
	belongs_to :bank_account
	belongs_to :operation_type
end