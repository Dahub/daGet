class Operation < ActiveRecord::Base
	belongs_to :operation_classification
	belongs_to :bank_account
	belongs_to :operation_type
	has_one :transfer
	
	belongs_to :user,
		inverse_of: :operations		
	
	enum movement: { output: 0, input: 1 }
	enum movement_type: { normal: 0, transfer: 1 }
	enum operation_valid: { not_ok: 0, ok: 1}
	
	validates	:amount,
				:presence => { message: "Le montant est obligatoire" }, 
				:numericality => { message: "Le montant doit être numérique" }
	validates	:wording,
				:presence => { message: "Le libellé est obligatoire" }
	validates	:date_operation,
				:presence => { message: "La date est obligatoire" }
end



# Operation.joins(bank_account: :user).where(users: { id: 1 })