require 'adventure/world.rb'

module Adventure
  extend self
  def run(config)
    World.load(config)
    puts "At any time type help for a list of commands"
    while (true)
      do_turn
    end
  end
  
  def print_commands
    puts "Command list:"
    puts "\t help -Show this screen"
    puts "\t go <direction>  -Goes in the direction specified"
    puts "\t exit  -Exit the program"
  end
  
  def print_state
    puts World.room.description
    World.room.doors.keys.each do |direction|
      str = "You see a door to the #{direction}"      
      if Hash===World.room.doors[direction] && World.room.doors[direction]['locked'] then
        str += " (locked)"
      end
      puts str
    end
  end
  
  def do_turn()
    print_state
    command = get_command
    puts case command[0]
    when 'go' then
      if World.go(command[1])
        "You go #{command[1]}"
      else
        "You can't go that way"
      end
    when 'exit' then exit
    when 'help' then print_commands
    else 'I have no idea what your talking about'
    end
  end
  
  def get_command()
    print "What will you do? > "
    STDIN.gets.chomp.downcase.split(/\s/)
  end
  
end