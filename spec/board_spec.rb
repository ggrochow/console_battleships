require_relative 'spec_helper'

describe Board do

  # describe '.play' do
  #   it "should add a hit to the correct ship if hit" do
  #     hits = Board::CRUISER.hits
  #     Board.play('A4')
  #     expect(Board::CRUISER.hits).to eq(hits + 1)
  #   end
  # end

  describe '.all_ships' do
    it "should return an array of all the ship objects" do
      expect(Board.all_ships[0]).to be_a(Battleship)
      expect(Board.all_ships[1]).to be_a(Destroyer)
      expect(Board.all_ships[2]).to be_a(Cruiser)
    end
  end

  describe '.remaining_ships' do
    it "should return an array containing the ships that are alive" do
      expect(Board::BATTLESHIP).to receive(:alive?).and_return(false)
      remaining_ships = Board.remaining_ships
      expect(remaining_ships).to_not include(Board::BATTLESHIP)
    end
  end
end
