module Helpers
  helpers do
    def titleize(text)
      count  = 0
      result = []
  
      for w in text.downcase.split
        count += 1
        if count == 1
          # Always capitalize the first word.
          result << w.capitalize
        else
          unless ['a','an','and','by','for','in','is','of','not','on','or','over','the','to','under'].include? w
            result << w.capitalize
          else
            result << w
          end
        end
      end

      return result.join(' ')
    end
  end
    
end