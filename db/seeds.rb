﻿# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
myUser = User.create(username: 'testeur', email: 'testeur@test.com', password: '37268335dd6931045bdcdf92623ff819a64244b53d0e746d438797349d4da578')
myDevise = Devise.create(symbol: '€', wording: 'euro')
@bankAccountTypes = BankAccountType.create([{ wording: 'Compte courant' },{ wording: 'Compte épargne' }])
@bankAccounts = BankAccount.create(user: myUser, bank_account_type: @bankAccountTypes.first, devise: myDevise, initial_amount: 150, final_amount: 212.64, name: 'compte test')

# postes d'opérations
@operationClassifications = OperationClassification.create([{wording: 'Salaire'}, {wording: 'Alimentation'}, {wording: 'Automobile'}, {wording: 'Loyer'}])

Operation.create(bank_account: @bankAccounts, 
	operation_classification: @operationClassifications.first, 
	movement: 'input', wording: 'Salaire 1', 
	amount: 1500, date_operation: '01/09/2014')
Operation.create(bank_account: @bankAccounts, 
	operation_classification: @operationClassifications.last, 
	movement: 'output', wording: 'Loyer', 
	amount: 700, date_operation: '04/09/2014')
Operation.create(bank_account: @bankAccounts, 
	operation_classification: @operationClassifications[2], 
	movement: 'output', wording: 'Divers', 
	amount: 120.15, date_operation: '08/09/2014')