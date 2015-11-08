require_relative 'spec_helper'

describe Ship do
  before :each do 
    @ship = Ship.new(2, 2)
  end

  describe "#alive?" do
    it "should return false if hits < max_hits" do
      expect(@ship.alive?).to eq(true)
    end

    it "should return false if hits >= max_hits" do
      expect(@ship).to receive(:hits).and_return(2)
      expect(@ship.alive?).to eq(false)
    end
  end 
end