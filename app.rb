require 'rubygems'
require 'compass'
require 'sinatra'
require 'partials'
require 'mongo_mapper'
require 'Play'
require 'Replacement'
require 'Result'
require 'Map'
require 'helpers'

helpers Sinatra::Partials

MongoMapper.connection = Mongo::Connection.new('192.168.0.100', 27017) 
MongoMapper.database = 'holiday'
get '/' do
  haml :index
end

get '/titles' do
  map = Map.new(Play.collection)
  coll = map.count_by("title")
  @results = coll.find({})
#   @results = coll.find({}).sort([["value", -1]])
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
  @method = params[:method]
  @map = Map.new(Play.collection)
  case @method 
    when "count"
      @results = @map.group_by_count(@x, @y)
  end
  @cols = @map.columns
  @rows = @map.rows
  @stats = @map.table_stats
  @stat_rows = @map.stat_rows
#   @results = coll.find({}).sort([["value", -1]])
  haml :x_by_y
  
end



get '/hi' do
  "Hello World!"
end

get '/replacement/new' do
  rep = {:replacement => {"from" => params[:title], "to" => "insert title"}}
  in_case = Replacement.create(rep)
  p params[:title]
  @replacement = Replacement.where(:from => params[:title]).limit(1) || in_case 
  
  haml :edit_replace
end

post '/edit_replace/:id' do
  p params[:id]
  @replacement = Replacement.find(params[:id])
  @replacement.update_attributes(params[:replacement])
end