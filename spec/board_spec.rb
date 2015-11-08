require_relative 'spec_helper'

describe Board do

  describe '.play' do
    it "should add a hit to the correct ship if hit" do
      hits = Board::CRUISER.hits
      Board.play('A4')
      expect(Board::CRUISER.hits).to eq(hits + 1)
    end
  end

end
