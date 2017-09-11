class User < ApplicationRecord
	before_create :create_remember_token
 	has_many :authentications, dependent: :destroy
 	has_many :posts, dependent: :destroy
 	has_many :comments, dependent: :destroy

	validates :name, presence: true, length: { maximum: 50 }
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
			     	  uniqueness: true

	has_secure_password
	validates :password, presence: true, length: { minimum: 6 }
	validates :password_confirmation, presence: true
	
	def User.new_remember_token
	  SecureRandom.urlsafe_base64
	end

	def User.digest(token)
	  Digest::SHA1.hexdigest(token.to_s)
	end
	
    def self.create_with_auth_and_hash(authentication, auth_hash)
      user = self.create!(
        name: auth_hash["info"]["name"],
        email: auth_hash["extra"]["raw_info"]["email"],
        password: SecureRandom.hex(6)
      )
      user.authentications << authentication
      return user
    end

    # grab fb_token to access Facebook for user data
    def fb_token
      x = self.authentications.find_by(provider: 'facebook')
      return x.token unless x.nil?
    end

	private

		def create_remember_token
			self.remember_token = User.digest(User.new_remember_token)
		end
end
