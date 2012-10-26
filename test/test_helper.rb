require 'mongo_mapper'
require 'database_cleaner'

ENV['RACK_ENV'] = 'test'

MongoMapper.database = 'moola-test'

DatabaseCleaner[:mongo_mapper].strategy = :truncation
