require 'sinatra'
require 'mongo_mapper'
require 'bcrypt'

class Moola < Sinatra::Application

  configure do
    MongoMapper.database = 'moola'

    enable :sessions
    set :session_secret, 'd3adb33fc0d3'
  end
end

require_relative 'models/init'
require_relative 'routes/init'
