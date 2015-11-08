require_relative 'spec_helper'

describe Player do
  before(:each) do
    @player = Player.new
  end
  describe '#fire' do
    it "should not fire a shot at an already hit posititon" do
      expect(@player).to receive(:hits).and_return(["A4"])
      @player.fire('A4')
      expect(@player.shots_fired).to eq(0)
    end
    it "should not fire a shot at an already missed posititon" do
      expect(@player).to receive(:misses).and_return(["B3"])
      @player.fire('B3')
      expect(@player.shots_fired).to eq(0)
    end
  end
end