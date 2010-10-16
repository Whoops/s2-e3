require 'adventure/room'
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
      if(@room.doors[direction] && !@room.doors[direction].locked)
        @room = @room.doors[direction].to
      end
    end
    
  end
end