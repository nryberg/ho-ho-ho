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
   
   # TODO : Change this output to a usable hash, rather than the opaque collection that's hard to query and sort
   # NPR, 12/26/2010
   
   return output
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
