# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20140723191944) do

	create_table "users", force: true do |t|
		t.string   	"username"
		t.string	"fullname"
		t.string   	"email"
		t.string   	"password"
		t.datetime 	"created_at"
		t.datetime 	"updated_at"
	end
	
	create_table "devises", force: true do |d|
		d.string	"symbol"
		d.string	"wording"
		d.datetime 	"created_at"
		d.datetime 	"updated_at"
	end	
  
	create_table "bank_account_types", force: true do |b|
		b.string	"wording"
		b.datetime 	"created_at"
		b.datetime 	"updated_at"
	end
  
	create_table "bank_accounts", force: true do |b|
		b.integer 	"user_id"
		b.integer	"devise_id"
		b.integer 	"bank_account_type_id"
		b.string 	"name"
		b.string    "account_number"
		b.string	"account_owner"
		b.decimal	"initial_amount", :precision => 10, :scale => 2
		b.decimal	"final_amount", :precision => 10, :scale => 2
		b.datetime 	"created_at"
		b.datetime 	"updated_at"
	end
	
	create_table "operation_classification_defaults", force: true do |a|
		a.string	"wording"
		a.datetime 	"created_at"
		a.datetime 	"updated_at"
	end
	
	create_table "operation_classifications", force: true do |a|
		a.string	"wording"
		a.integer	"user_id"
		a.datetime 	"created_at"
		a.datetime 	"updated_at"
	end
	
	create_table "operations", force: true do |a|
		a.integer	"bank_account_id"
		a.integer	"movement"
		a.integer	"movement_type"
		a.integer	"operation_valid",	:default => 0
		a.integer	"operation_classification_id"
		a.string	"wording"
		a.decimal	"amount", :precision => 10, :scale => 2
		a.datetime	"date_operation"		
		a.datetime 	"created_at"
		a.datetime 	"updated_at"
	end	
	
	create_table "transfers", force: true do |t|
		t.string	"wording"
		t.integer	"from_bank_account_id"
		t.integer	"to_bank_account_id"
		t.integer	"from_operation_id"
		t.integer	"operation_classification_id"
		t.integer	"to_operation_id"
		t.decimal	"amount", :precision => 10, :scale => 2
		t.datetime	"date_transfer"
		t.datetime 	"created_at"
		t.datetime 	"updated_at"
	end
	
	
end
