require_relative 'spec_helper'

describe Cruiser do
  before :each do
    @cruiser = Cruiser.new
  end

  it "should be a ship" do
    expect(@cruiser).to be_a(Ship)
  end

  it "should have length 2" do
    expect(@cruiser.length).to eq(2)
  end

  it "should have 4 max_hits" do
    expect(@cruiser.max_hits).to eq(2)
  end
end
