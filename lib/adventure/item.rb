module Adventure
  module World
    
    class Item
      
      attr_accessor :name, :description, :unlocks, :used
      def initialize(attrs)
        attrs.each do |attr, key|
          send("#{attr}=",key)
        end
      end
      
    end
    
  end
end