require File.dirname(__FILE__) + '/../spec_helper'
require File.join(libs,'adventure','door')

include Adventure::World

describe Door do
  it "should lookup the appropriate room in world" do
    World.load({
      'rooms' => [{'name' => 'roomy'}],
      'items' => []
      })
    Door.new('roomy').to.should equal(World.rooms['roomy'])
  end
end