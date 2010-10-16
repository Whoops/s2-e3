require File.dirname(__FILE__) + '/../spec_helper'
require File.join(libs,'adventure','room')

include Adventure::World

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
  
  it "should build a collection of door objects" do
    room=Room.new("name"=>'foo')
    room.doors={ "west" => 'roomA',
      "east" => 'roomB' }
    room.doors.count.should == 2
    room.doors.each do |key, value|
      value.class.should == Door
    end
  end

end