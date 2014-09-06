class User < ActiveRecord::Base
	EMAIL_REGEX = /\A[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\z/i
	validates 	:username, 
				presence: { message: "Le login est obligatoire" }, 
				uniqueness: { message: "Login déjà utilisé" },
				length: { in: 3..20, message: "Le nom d'utilisateur doit comporter entre 3 et 20 caractères" }
	validates 	:email, 
				presence: { message: "L'adresse email est obligatoire" }, 
				uniqueness: { message: "Email déjà existant" }, 
				format: { with: EMAIL_REGEX, message: "Format de mail incorrect" }
	validates 	:password, 
				presence: { message: "Mot de passe obligatoire" }, 
				confirmation: { message: "Les mots de passe ne correspondent pas" }
	validates	:fullname,
				presence: { message: "Nom obligatoire" }
	#validates_length_of :password, :in => 6..500, :on => :create
	
	has_many :bankAccounts, dependent: :destroy,
		inverse_of: :user
		
	has_many :operations,
		inverse_of: :user
		
	has_many :operation_classifications
	
	def self.get_by_login_and_password(login = "", password = "")
		return User.where(:username=>login).where(:password=>Digest::SHA2.hexdigest(password)).first	
	end
	
	def self.add_user(to_add)
		# crypt password
		to_add.password = Digest::SHA2.hexdigest(to_add.password)
		to_add.password_confirmation = Digest::SHA2.hexdigest(to_add.password_confirmation)
		
		# add defaults operations
		OperationClassificationDefault.all.each do |o|
			to_add.operation_classifications << (OperationClassification.new(wording: o.wording))
		end
		
		to_add.save
	end
end
