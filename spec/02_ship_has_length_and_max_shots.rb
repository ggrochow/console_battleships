require_relative 'spec_helper'

describe Ship do
  describe 'have length of 2 and max shots of 5' do
    before :each do
      @ship = Ship.new(2, 5)
    end

    it "should have length of 2" do
      expect(@ship.length).to eq(2)
    end

    it "should have 5 max_shots" do
      expect(@ship.max_shots).to eq(5)
    end

    it "should have 0 hits" do
      expect(@ship.hits).to eq(0)
    end
  end

  describe 'have length of 5 and max shots of 25' do
    before :each do
      @ship = Ship.new(5, 25)
    end

    it "should have length of 5" do
      expect(@ship.length).to eq(5)
    end

    it "should have 25 max_shots" do
      expect(@ship.max_shots).to eq(25)
    end

    it "should have 0 hits" do
      expect(@ship.hits).to eq(0)
    end
  end
end
