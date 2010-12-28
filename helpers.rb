module Helpers
  helpers do
    def titlecase(text)
        non_capitalized = %w{of etc and by the for on is at to but nor or a via}
        text.gsub!(/\b[a-z]+/){ |w| non_capitalized.include?(w) ? w : w.capitalize  }.sub(/^[a-z]/){|l| l.upcase }.sub(/\b[a-z][^\s]*?$/){|l| l.capitalize }
    end
  end
    
end