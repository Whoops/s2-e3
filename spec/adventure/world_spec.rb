require File.dirname(__FILE__) + '/../spec_helper'
require File.join(libs,'adventure','world')
include Adventure
describe World do

  describe "loading" do
    before(:each) do
      @rooms = {'rooms' => [
        { 'name' => 'atrium', 'description' => 'A vast atrium' },
        { 'name' => 'hallway', 'description' => 'A grand entranceway'}
      ],
      'items' => []};
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
  
  describe 'items' do
    before(:each) do
      @config = {'rooms' => [
        { 'name' => 'atrium', 'initial'=>true, 'doors'=>{ 'north' => { 'to' => 'foyer', 'locked' => true } } },
        { 'name' => 'foyer' }
        ],
      'items' => [
        { 'name' => 'key', 'room'=>'atrium', 'unlocks' => { 'room' => 'atrium', 'door' => 'north' } }
        ]}
      World.load(@config)
    end
    
    it "should put items in the proper room" do
      World.rooms['atrium'].items.length.should == 1
      World.rooms['atrium'].items['key'].should_not be_nil
      World.rooms['foyer'].items.length.should == 0
    end
    
    it "should allow items to be picked up" do
      World.room.items['key'].should_not be_nil
      World.pick('key').should be_true
      World.inventory['key'].should_not be_nil
      World.room.items['key'].should be_nil
    end
    
    it "should not allow items to be picked up that are not in the same room" do
      World.instance_variable_set('@room', World.rooms['foyer'])
      World.pick('key').should be_false
    end
    
    it "should allow items to be dropped" do
      World.pick('key')
      World.instance_variable_set('@room', World.rooms['foyer'])
      World.drop('key')
      World.inventory.should be_empty
      World.room.items['key'].should_not be_nil
    end
    
    it "should allow items to be used" do
      World.room.doors['north'].should be_locked
      World.pick('key')
      World.use('key').should be_true
      World.room.doors['north'].should_not be_locked
    end
    
    it "should not allow items to be used in the wrong room" do
      World.pick('key')
      World.instance_variable_set('@room', World.rooms['foyer'])
      World.use('key').should be_false
      World.rooms['atrium'].doors['north'].should be_locked
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
          'south' => 'driveway',
          'east' => {
            'to' => 'locked room',
            'locked' => true
          }
        }
      },
        {
        'name' => 'living_room',
        'description' => 'The living room',
        'doors' => { 'east' => 'entryway' }
        },
        {
          'name' => 'locked room',
          'description' => 'A locked room'
        }
      ],
      'items' => []}
      World.load(@rooms_doors)
    end
    
    it "should allow movement between rooms do" do
      World.room.name.should == 'driveway'
      World.go('north').should be_true
      World.room.name.should == 'entryway'
      World.go('west').should be_true
      World.room.name.should == 'living_room'
      World.go('east').should be_true
      World.room.name.should == 'entryway'
    end
    
    it "should not allow movement through nonexistant doors" do      
      World.room.name.should == 'driveway'
      World.go('south').should be_false
      World.room.name.should == 'driveway'
    end
    
    it "should not allow one to pass through locked doors" do
      World.go('north') #move to the hallway
      World.room.name.should == 'entryway'
      World.go('east').should be_false
      World.room.name.should == 'entryway'
    end

  end
end
