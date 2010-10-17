module Adventure
  module World
    
    
    class Door
      attr_accessor :locked, :description
      
      def initialize(dest, desc=nil, lock=false)
        @to=dest
        @description=desc
        @locked=lock
      end
      
      def to
        World.rooms[@to]
      end
      
      def to=(value)
        @to=value
      end
      
      def locked?
        @locked
      end
      
    end
  end
end