require 'rubygems'
require 'sinatra'
require 'mongo_mapper'
require 'Play'
require 'Map'

MongoMapper.connection = Mongo::Connection.new('192.168.0.100', 27017) 
MongoMapper.database = 'holiday'
get '/' do
  @plays = Play.limit(20).sort(:title)
  haml :index
end

get '/titles' do
  map = Map.new(Play.collection)
  @results = map.count_by("title", "sample")
  haml :titles
end



get '/hi' do
  "Hello World!"
end