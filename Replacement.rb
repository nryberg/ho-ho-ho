class Replacement 
  include MongoMapper::Document
  key :from, String
  key :to, String
end
