require 'adventure/door'

module Adventure
  module World

    class Room
      attr_accessor :name, :description, :victory
      attr_accessor :items

      def initialize(attrs)
        attrs.each do |attr, key|
          send("#{attr}=",key)
        end
        @items ||= {}
        @doors ||= {}
      end
      
      def doors
        return @doors
      end
      
      def doors=(hash)
        @doors={}
        
        hash.each do |direction, door|
          @doors[direction] = if Hash===door then
            Door.new(door['to'],door['description'],door['locked'])
          else
            Door.new(door)
          end
        end
        
      end

    end

  end
end