require 'sinatra'
require 'mongo_mapper'

class Moola < Sinatra::Application
  enable :sessions

  configure do
    MongoMapper.database = 'moola'
  end
end

require_relative 'models/init'
require_relative 'routes/init'
