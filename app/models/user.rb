class User < ActiveRecord::Base
	EMAIL_REGEX = /\A[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\z/i
	validates :username, :presence => true, :uniqueness => true, :length => { :in => 3..20 }
	validates :email, :presence => true, :uniqueness => true, :format => EMAIL_REGEX
	#validates :password, :confirmation => true 
	#validates_length_of :password, :in => 6..500, :on => :create
	
	def self.get_by_login_and_password(login = "", password = "")
		return User.where(:username=>login).where(:password=>Digest::SHA2.hexdigest(password)).first	
	end
end
