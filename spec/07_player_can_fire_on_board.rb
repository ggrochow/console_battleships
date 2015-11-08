require_relative 'spec_helper'

describe Player do
  before :each do
    @player = Player.new
  end

  describe "initial state" do
    it "to have no hits or misses" do
      expect(@player.hits).to eq([])
      expect(@player.misses).to eq([])
    end
  end

  describe '#fire' do
    it 'calls Board.play with the given position' do
      expect(Board).to receive(:play).with('D6').and_return(nil)
      expect(@player.fire('D6')).to be_nil
    end

    it 'records spots it scored a hit' do
      expect(Board).to receive(:play).with('F6').and_return(Destroyer.new)
      expect(@player.fire('F6')).to be_a(Destroyer)
      expect(@player.hits[0]).to eq('F6')
    end

    it 'records spots it missed' do
      expect(Board).to receive(:play).with('A1').and_return(nil)
      expect(@player.fire('A1')).to be_nil
      expect(@player.misses[0]).to eq('A1')
    end

    it 'returns false if the max shots is reached' do
      expect(Board).to_not receive(:play)
      expect(@player).to receive(:shots_fired).and_return(10)
      expect(@player.fire('F2')).to eq(false)
    end
  end
end
