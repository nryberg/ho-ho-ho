require 'rubygems'
require 'compass'
require 'sinatra'
require 'partials'
require 'mongo_mapper'
require 'Play'
require 'Result'
require 'Map'

helpers Sinatra::Partials

MongoMapper.connection = Mongo::Connection.new('192.168.0.100', 27017) 
MongoMapper.database = 'holiday'
get '/' do
  haml :index
end

get '/titles' do
  map = Map.new(Play.collection)
  coll = map.count_by("title")
  @results = coll.find({}).sort([["value", -1]])
#   p map.collection_name
  haml :titles
end

get '/cities' do
  map = Map.new(Play.collection)
  coll = map.count_by("city")
  @results = coll.find({}).sort([["value", -1]])
  haml :cities
end

get '/x_by_y' do
  @x = params[:x]
  @y = params[:y]
  map = Map.new(Play.collection)
  @results = map.group_by_count(@x, @y)
  @cols = map.columns
  @rows = map.rows
#   @results = coll.find({}).sort([["value", -1]])
  haml :x_by_y
  
end
  

get '/hi' do
  "Hello World!"
end