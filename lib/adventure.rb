require 'adventure/world.rb'

module Adventure
  extend self
  def run(config)
    @done=false
    World.load(config)
    puts "At any time type help for a list of commands"
    while (!@done)
      do_turn
    end
  end
  
  def victory
    print_state
    puts "Congratulations, you've won!"
    @done=true
  end
  
  def print_commands
    puts "Command list:"
    puts "\t help -Show this screen"
    puts "\t go <direction>  -Goes in the direction specified"
    puts "\t pick up <item> -Picks up the item denoted by item"
    puts "\t\t\t Note: look for item names inside (parens)"
    puts "\t drop <item> -Drops the item. It can be picked up later"
    puts "\t use <item> -Uses the item, you must be in the right room"
    puts "\t exit  -Exit the program"
  end
  
  def print_state    
    puts World.room.description
    puts "" if World.room.items.length > 0
    World.room.items.each do |key, value|
      puts "#{value.description} (#{key})"
    end
    puts "\n"
    print_doors
  end
  
  def print_doors
    World.room.doors.keys.each do |direction|
      room=World.room.doors[direction]
      
      str="#{room.description || 'You see a room to the'} (#{direction})"
      
      str += case room.locked
      when String then " #{room.locked}"
      when true then " (locked)"
      else ""
      end
      
      puts str
    end
  end
    
  
  def do_turn()
    print_state
    command = get_command
    
    puts "\n\n"
    
    puts case command[0]
    when 'go' then
      if World.go(command[1])
        "You go #{command[1]}"
      else
        "You can't go that way"
      end
    when 'pick' then
      if World.pick(command[2])
        "You pick up #{command[2]}"
      else
        "You can't take that!"
      end
    when 'use' then
      if item=World.use(command[1])
        item.used
      else
        "You can't use that here!"
      end
    when 'drop' then
      if World.drop(command[1])
        "You drop #{command[1]}"
      else
        "You don't have #{command[1]}!"
      end
    when 'exit' then @done=true; ""
    when 'help' then print_commands; ""
    else 'I have no idea what your talking about'
    end
    victory if World.room.victory
  end
  
  def get_command()
    print "What will you do? > "
    STDIN.gets.chomp.downcase.split(/\s/)
  end
  
end