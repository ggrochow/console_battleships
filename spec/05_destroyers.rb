require_relative 'spec_helper'

describe Destroyer do
  before :each do
    @destroyer = Destroyer.new
  end

  it "should be a ship" do
    expect(@destroyer).to be_a(Ship)
  end

  it "should have length 4" do
    expect(@destroyer.length).to eq(4)
  end

  it "should have 4 max_shots" do
    expect(@destroyer.max_shots).to eq(4)
  end
end
