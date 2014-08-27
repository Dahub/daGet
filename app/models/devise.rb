class Devise < ActiveRecord::Base
	has_many :bankAccounts, dependent: :destroy
end