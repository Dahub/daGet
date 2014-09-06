class OperationClassification < ActiveRecord::Base
	has_many :operations
	has_many :transfers
	belongs_to :user
end