require 'mongo_mapper'

class Moola < Sinatra::Application

  helpers do
    def logged_in?
      !!session[:user_id]
    end

    def current_user
      User.find(session[:user_id])
    end

    def valid_credentials username,password
      username.length >= 4 and password.length >= 6
    end
  end
end
