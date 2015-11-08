require_relative 'spec_helper'

describe Player do
  before :each do
    @player = Player.new
  end

  it "has not fired yet" do
    expect(@player.shots_fired).to eq(0)
  end

  describe '#fire' do
    it 'can fire a shot at a coordinate' do
      @player.fire('A6')
      expect(@player.shots_fired).to eq(1)
      @player.fire('A7')
      expect(@player.shots_fired).to eq(2)
    end

    it "can't fire more than ten shots" do
      allow(@player).to receive(:shots_fired).and_return(20)
      expect(@player.fire('C7')).to eq(false)
    end
  end
end
