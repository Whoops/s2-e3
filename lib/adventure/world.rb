require 'adventure/room'
require 'adventure/door'
require 'adventure/item'

module Adventure
  module World
    extend self
    
    attr_reader :rooms, :items, :inventory, :room
    
    def load(config)
      @rooms={}
      @items={}
      @inventory={}
      
      config['rooms'].each do |r|
        initial=r.delete('initial')
        room=Room.new(r)
        @rooms[room.name] = room
        @room = room if initial
      end
      
      config['items'].each do |i|
        room=i.delete('room')
        item=Item.new(i)
        @items[item.name]=room
        World.rooms[room].items[item.name]=item
      end
      
    end
    
    def go(direction)      
      if(@room.doors[direction] && !@room.doors[direction].locked?)
        @room = @room.doors[direction].to
      end
    end
    
    def pick(i)
      item=@room.items.delete(i)
      @inventory[item.name]=item if item
    end
    
    def drop(i)
      item=@inventory.delete(i)
      @room.items[item.name]=item if item
    end
    
    def use(i)
      item=@inventory[i]
      return nil unless item
      if(@room.name==item.unlocks['room'])
        @room.doors[item.unlocks['door']].locked=false
        true
      end
    end
    
  end
end