class Map
  attr_reader :collection, :collection_name, :columns, :rows
  def initialize(collection)
    @collection = collection
    
  end
  
  def count_by(item)
    m = "function(){
        emit(this.ITEM.toLowerCase(), 1);
        }"
    m.gsub!("ITEM", item)
    r = reduce_count
    @collection.map_reduce(m,r)
    
  end
  
  def collection_name 
    @collection_name = @collection.name
  end
  
  
  def group_by_count(item1, item2)
    m = "function(){
          emit({" + item1 + " : this." + item1 + ", " +
                    item2 + " : this." + item2 +
              "},
            1);
          }"
    
   r = reduce_count    
   output = @collection.map_reduce(m,r)
   @columns = output.distinct("_id." + item2)
   @rows = output.distinct("_id." + item1)
   
   
   # DONE : Changed this output to a usable hash, rather than the opaque collection that's hard to query and sort
   # NPR, 12/26/2010
   # Not convinced this is the best route, but on the other hand, don't want to be hitting db all the time.
   
   # TODO: Fix the output to a string instead of a Mongo cursor.  Still seems like a lot of work. :(
   
   table = Hash.new
  
   @rows.each do |@row|
     @columns.each do |col|
       value = output.find({"_id." + item1 => @row, "_id." + item2 => col}, {:fields => ["value"]})
       
       table[@row.to_s + col.to_s] = value
     end
   end
   
#    output.find().each do |line|
#      row_col = line["_id"]
#      data = Hash.new
#      row = row_col[item1]
#      col = row_col[item2]
#      row_data = table[ 
#      table[row][col] = data
#    end
   return table
  end
    
             
  
  def reduce_count()
     r = "function(k, vals){
       var sum = 0;
       vals.forEach(function(val) {
         sum += val;
         });
       return sum;
       };"
  end
    
    
  
  
  
end
