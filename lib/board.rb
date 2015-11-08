class Board
  class OffBoardError < StandardError
  end

  MAX_X = 9
  MIN_X = 0

  # Types of Ship
  BATTLESHIP = Battleship.new
  DESTROYER  = Destroyer.new
  CRUISER    = Cruiser.new
  EMPTY      = nil

  BOARD_KEY  = { 'B' => BATTLESHIP, 'D' => DESTROYER, 'C' => CRUISER, '~' => EMPTY }

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
      validiate_coordinates(row,column)
      # Returning new ships each time feels wrong
      target = BOARD_KEY[GRID[row][column]]
      target.hit unless target.nil?
      target
    end

    def all_ships
      [BATTLESHIP, DESTROYER, CRUISER]
    end

    def remaining_ships
      all_ships.select { |ship| ship.alive? }
    end

    private

    def random_position
      random_row + random_column.to_s
    end

    def random_row
      ("A".."G").to_a.sample
    end

    def random_column
      (MIN_X..MAX_X).to_a.sample
    end

    def validiate_coordinates(row, column)
      raise OffBoardError, "Play #{row}#{column + 1} off board" unless valid_row?(row) && valid_column?(column)
    end

    def get_row(position)
      position[0].to_sym
    end

    def get_column(position)
      position[1..-1].to_i - 1
    end

    def valid_row?(row)
      GRID.has_key?(row)
    end

    def valid_column?(column)
      (MIN_X..MAX_X).include?(column)
    end

  end

end
