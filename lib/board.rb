class Board
  class OffBoardError < StandardError
  end

  MAX_X = 9
  MIN_X = 0
  # Types of Ship
  BATTLESHIP = 'B'
  DESTROYER  = 'D'
  CRUISER    = 'C'
  EMPTY      = '~'

  # The grid below represents the game grid. It's a hash of arrays of strings.
  # Don't let the weird syntax confuse you. It's just a fancy way of defining an array of strings. 
  # Each row is actual an array of strings. Each spot is either empty (~) or has a ship: Battleship (B), Destroyer(D), or Cruiser(C).

  GRID = {
    #     0 1 2 3 4 5 6 7 8 9
    A: %w{~ ~ ~ C ~ ~ ~ B ~ ~},
    B: %w{~ ~ ~ C ~ ~ ~ B ~ ~},
    C: %w{~ ~ ~ ~ ~ ~ ~ B ~ ~},
    D: %w{~ ~ ~ ~ ~ ~ ~ B ~ ~},
    E: %w{~ ~ C C ~ ~ ~ ~ ~ ~},
    F: %w{~ ~ ~ ~ ~ D D D D ~},
    G: %w{~ ~ ~ ~ ~ ~ ~ ~ ~ ~}
  }

  class << self

    def play(position)
      row = get_row(position)
      column = get_column(position)
      position_on_board_check(row,column)
      # Returning new ships each time feels wrong
      case GRID[row][column]
      when BATTLESHIP then Battleship.new
      when DESTROYER then Destroyer.new
      when CRUISER then Cruiser.new
      when EMPTY then nil
      end
    end

    private
    def position_on_board_check(row, column)
      raise OffBoardError, "Play #{row}#{column + 1} off board" unless valid_row?(row) && valid_column?(column)
    end

    def get_row(position)
      position[0].to_sym
    end

    def get_column(position)
      position.gsub(/\D/, "").to_i - 1
    end

    def valid_row?(row)
      GRID.has_key?(row)
    end

    def valid_column?(column)
      (MIN_X..MAX_X).include?(column)
    end

  end

end