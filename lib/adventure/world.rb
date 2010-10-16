module Adventure
  module World
    extend self
    
    attr_reader :rooms, :room
    
    def load(config)
      @rooms={}
      config['rooms'].each do |r|
        initial=r.delete('initial')
        room=Room.new(r)
        @rooms[room.name] = room
        @room = room if initial
      end
    end
    
    def go(direction)      
      if Hash === @room.doors[direction] then
        unless @room.doors[direction]['locked']
          @room=rooms[@room.doors[direction]['to']]
        end
      else
        @room=rooms[@room.doors[direction]] if @room.doors[direction]
      end
    end
    
    class Room
      attr_accessor :name, :description, :doors
      def initialize(attrs)
        attrs.each do |attr, key|
          send("#{attr}=",key)
        end
      end
    end
    
  end
end