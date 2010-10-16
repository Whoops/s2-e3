require File.dirname(__FILE__) + '/../spec_helper'
require File.join(libs,'adventure','world')
include Adventure
include World
describe World do
  before(:each) do
    @rooms=config = {'rooms' => [
      { 'name' => 'atrium', 'description' => 'A vast atrium' },
      { 'name' => 'hallway', 'description' => 'A grand entranceway'}
      ]};      
  end
  it "should load a hash of rooms" do
    config = @rooms
    World.load(config)
    World.rooms.length.should == 2
    World.rooms.should have_key('atrium')
    World.rooms.should have_key('hallway')
  end
  
  it "should set the current room to the initial room" do
    config=@rooms.dup
    config['rooms'] << { 'name' => 'driveway',
      'description' => 'An expansive driveway, much larger than you will ever afford',
      'initial' => true }
    World.load(config)
    World.room.name.should == 'driveway'
    
  end
  
  describe Room do
    it "take a hash of attributes" do
      room = Room.new(:name=>'foo', :description=>'foobar')
      room.name.should == 'foo'
      room.description.should == 'foobar'
    end
    
    it "should raise a NoMethodError when an attribute does not exist" do
      lambda do 
        room=Room.new(:fuzz=>'jackrabbit')
      end.should raise_error NoMethodError
    end
    
  end
end
