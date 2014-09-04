# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
myUser = User.create(username: 'testeur', email: 'testeur@test.com', password: '37268335dd6931045bdcdf92623ff819a64244b53d0e746d438797349d4da578', fullname: 'David André')
myDevise = Devise.create(symbol: '€', wording: 'euro')
@bankAccountTypes = BankAccountType.create([{ wording: 'Compte courant' },{ wording: 'Compte épargne' }])
@bankAccounts = BankAccount.create(user: myUser, bank_account_type: @bankAccountTypes.first, devise: myDevise, initial_amount: 150, final_amount: 212.64, name: 'CCP principal')
@bankAccounts = BankAccount.create(user: myUser, bank_account_type: @bankAccountTypes.first, devise: myDevise, initial_amount: 12, final_amount: -75, name: 'CPP de test')
@bankAccounts = BankAccount.create(user: myUser, bank_account_type: @bankAccountTypes.last, devise: myDevise, initial_amount: 0, final_amount: 4521, name: 'Livret A')

OperationClassificationDefault.create([
	{wording: 'Alimentation'},{wording: 'Santé'},{wording: 'Charges'},{wording: 'Eau'},
	{wording: 'Gaz'},{wording: 'Electricité'},{wording: 'Loyer'},{wording: 'Remboursement prêt'},
	{wording: 'Loisir'},{wording: 'Sortie'},{wording: 'Cadeau'},{wording: 'Don'},
	{wording: 'Frais banquaires'},{wording: 'Scolarité'},{wording: 'Habillement'},{wording: 'Assurance'},
	{wording: 'Impôts'},{wording: 'Salaire'},{wording: 'Securité sociale'},{wording: 'Remboursement frais'}
])

# postes d'opérations
@operationClassifications = OperationClassification.create([
	{wording: 'Alimentation', user_id: 1}, {wording: 'Equipement maison', user_id: 1}, {wording: 'Téléphonie', user_id: 1}, {wording: 'Transports', user_id: 1},
	{wording: 'Energie', user_id: 1}, {wording: 'Gaz', user_id: 1}, {wording: 'Eau', user_id: 1}, {wording:'Electricité', user_id: 1}, {wording: 'Santé', user_id: 1},
	{wording: 'Remboursement santé', user_id: 1}, {wording: 'Loisirs', user_id: 1}, {wording: 'Sortie', user_id: 1}, {wording: 'Cadeaux', user_id: 1},
	{wording: 'Scolarité', user_id: 1}, {wording: 'Voyage', user_id: 1}, {wording: 'Frais banquaires', user_id: 1}, {wording: 'Assurance', user_id: 1},
	{wording: 'Habillement', user_id: 1}, {wording: 'Frais professionnels', user_id: 1},
	{wording: 'Salaire', user_id: 1}, {wording: 'Impôts', user_id: 1}, {wording: 'Automobile', user_id: 1}, {wording: 'Loyer', user_id: 1}
])

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