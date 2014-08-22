# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
myUser = User.create(username: 'testeur', email: 'testeur@test.com', password: '37268335dd6931045bdcdf92623ff819a64244b53d0e746d438797349d4da578')
myDevise = Devise.create(symbol: '€', wording: 'euro')
BankAccount.create(user: myUser, devise: myDevise, initial_amount: 150, final_amount: 212.64, name: 'compte test')