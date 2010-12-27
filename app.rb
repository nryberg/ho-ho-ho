require 'rubygems'
require 'compass'
require 'sinatra'
require 'partials'
require 'mongo_mapper'
require 'Play'
require 'Map'

helpers Sinatra::Partials

MongoMapper.connection = Mongo::Connection.new('192.168.0.100', 27017) 
MongoMapper.database = 'holiday'
get '/' do
  @plays = Play.limit(20).sort(:title)
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

get '/city_by_day' do
  @x = "city"
  @y = "day"
  map = Map.new(Play.collection)
  coll = map.group_by_count(@x, @y)
  @cols = map.columns
  @rows = map.rows
  @results = coll.find({}).sort([["value", -1]])
  haml :x_by_y
  
end
  

get '/hi' do
  "Hello World!"
end