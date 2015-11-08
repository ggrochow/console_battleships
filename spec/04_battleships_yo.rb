require_relative 'spec_helper'

describe Battleship do
  before :each do
    @battleship = Battleship.new
  end

  it "should be a ship" do
    expect(@battleship).to be_a(Ship)
  end

  it "should have length 4" do
    expect(@battleship.length).to eq(4)
  end

  it "should have 4 max_shots" do
    expect(@battleship.max_shots).to eq(4)
  end
end
