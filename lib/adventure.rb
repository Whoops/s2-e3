require 'adventure/world.rb'

module Adventure
  extend self
  def run(config)
    World.load(config)
    while (true)
      do_turn
    end
  end
  
  def do_turn()
    puts World.room.description
    command = get_command
    puts case command[0]
    when 'go' then
      if World.go(command[1])
        "You go #{command[1]}"
      else
        "You can't go that way"
      end
    when 'exit' then exit
    else 'I have no idea what your talking about'
    end
  end
  
  def get_command()
    print "What will you do? > "
    STDIN.gets.chomp.split(/\s/)
  end
  
end