require 'sinatra'
require 'mongo_mapper'
require 'bcrypt'
require 'rack-flash'

class Moola < Sinatra::Application

  configure do
    MongoMapper.database = 'moola'

    enable :sessions
    set :session_secret, 'd3adb33fc0d3'

    use Rack::Flash
  end
end

require_relative 'models/init'
require_relative 'routes/init'
require_relative 'helpers/init'
