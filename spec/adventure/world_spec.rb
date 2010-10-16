require File.dirname(__FILE__) + '/../spec_helper'
require File.join(libs,'adventure','world')
include Adventure
include World
describe World do

  describe "loading" do
    before(:each) do
      @rooms = {'rooms' => [
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
      config = @rooms.dup
      config['rooms'] << { 'name' => 'driveway',
        'description' => 'An expansive driveway, much larger than you will ever afford',
        'initial' => true }
      World.load(config)
      World.room.name.should == 'driveway'
    end
  end


  describe "movement" do
    before(:each) do
      @rooms_doors = {'rooms' => [
        {
        'name' => 'driveway',
        'description' => 'The driveway',
        'initial' => true,
        'doors' => { 'north' => 'entryway' }
      },
        {
        'name' => 'entryway',
        'description' => 'The entryway',
        'doors' => {
        'west' => 'living_room',
        'south' => 'driveway'
      }
      },
        {
        'name' => 'living_room',
        'description' => 'The living room',
        'doors' => { 'east' => 'entryway' }
      }
      ]}
    end
    
    it "should allow movement between rooms do" do
      World.load(@rooms_doors)
      World.room.name.should == 'driveway'
      World.go('north').should be_true
      World.room.name.should == 'entryway'
      World.go('west').should be_true
      World.room.name.should == 'living_room'
      World.go('east').should be_true
      World.room.name.should == 'entryway'
    end
    
    it "should not allow movement through nonexistant doors" do
      World.load(@rooms_doors)
      World.room.name.should == 'driveway'
      World.go('south').should be_false
      World.room.name.should == 'driveway'
    end

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
