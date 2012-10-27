require 'bcrypt'

class User
  include MongoMapper::Document

  attr_accessor :password

  key :username, String, required: true
  key :password_hash, String
  key :password_salt, String

  many :expenses

  before_save :encrypt_password

  class << self
    def authenticate(user,pass)
      user = User.first(:conditions => {username: user})
      if user
        if user.password_hash == BCrypt::Engine.hash_secret(pass, user.password_salt)
          user
        else
          nil
        end
      end
    end
  end

  private
  def encrypt_password
    self.password_salt = BCrypt::Engine.generate_salt
    self.password_hash = BCrypt::Engine.hash_secret(password,password_salt)
  end
end
