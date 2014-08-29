class Operation < ActiveRecord::Base
	belongs_to :operation_classification
	belongs_to :bank_account
	belongs_to :operation_type
	
	enum movement: { output: 0, input: 1 }
	
	validates	:amount,
				:presence => { message: "Le montant est obligatoire" }, 
				:numericality => { message: "Le montant doit être numérique" }
	validates	:wording,
				:presence => { message: "Le libellé est obligatoire" }
	validates	:date_operation,
				:presence => { message: "La date est obligatoire" }
end