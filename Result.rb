class Result 
  include MongoMapper::Document
  key :_id, Hash, :typecast => 'ObjectID'
end
