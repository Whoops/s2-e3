module Adventure
  module World
    
    class Item
      
      attr_accessor :name, :description, :look, :unlocks
      def initialize(attrs)
        attrs.each do |attr, key|
          send("#{attr}=",key)
        end
      end
      
    end
    
  end
end