class OperationClassification < ActiveRecord::Base
	has_many :operations
	belongs_to :user
end