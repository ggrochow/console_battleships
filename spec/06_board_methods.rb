require_relative 'spec_helper'

describe Board do
  describe '.play' do
    it 'returns a battleship if there is a B at the position' do
      play = Board.play('A8')
      expect(play).to be_a(Battleship)
    end

    it 'returns a cruiser if there is a C at the position' do
      play = Board.play('B4')
      expect(play).to be_a(Cruiser)
    end

    it 'returns nothing if there is nothing (~) at the position' do
      play = Board.play('E9')
      expect(play).to be_nil
    end
  end
end
