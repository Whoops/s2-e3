module Adventure
  module World
    
    
    class Door
      attr_accessor :locked
      
      def initialize(dest, lock=false)
        @to=dest
        @locked=lock
      end
      
      def to
        World.rooms[@to]
      end
      
      def to=(value)
        @to=value
      end
      
    end
  end
end