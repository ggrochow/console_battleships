require_relative 'spec_helper'

describe Board do
  describe '.play' do
    it 'raises an error if a play is off the board' do
      expect { Board.play('H9') }.to raise_error(Board::OffBoardError, 'Play H9 off board')
    end

    it 'raises an error if a play is off the board' do
      expect { Board.play('D11') }.to raise_error(Board::OffBoardError, 'Play D11 off board')
    end

    it 'raises an error if a play is off the board' do
      expect { Board.play('A0') }.to raise_error(Board::OffBoardError, 'Play A0 off board')
    end

    it 'does not raise an error if the play is on the board' do
      expect { Board.play('E10') }.to_not raise_error
    end
  end
end
