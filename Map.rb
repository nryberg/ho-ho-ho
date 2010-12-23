class Map
  def initialize(collection)
    @collection = collection
    
  end
  
  def count_by(item, output)
    m = "function(){
        emit(this.ITEM.toLowerCase(), 1);
        }"
    m.gsub!("ITEM", item)
    
    r = "function(k, vals){
       var sum = 0;
       vals.forEach(function(val) {
         sum += val;
         });
       return sum;
       };"
    unless output.nil? then 
      @collection.map_reduce(m,r, {:out => output})
    else
      @collection.map_reduct(m,r)
    end
    
  end
  
  
  
end
