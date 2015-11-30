class Board

  MAX_X = 9
  MIN_X = 0

  # Types of Ship
  BATTLESHIP = Battleship.new
  DESTROYER  = Destroyer.new
  CRUISER    = Cruiser.new
  SUBMARINE  = Submarine.new
  EMPTY      = nil

  BOARD_KEY  = { 'B' => BATTLESHIP, 'D' => DESTROYER, 'C' => CRUISER, 'S' => SUBMARINE, '~' => EMPTY }

  GRID = [ 
    %w{~ ~ ~ ~ ~ ~ ~ ~ ~ ~},
    %w{~ ~ ~ ~ ~ ~ ~ ~ ~ ~},
    %w{~ ~ ~ ~ ~ ~ ~ ~ ~ ~},
    %w{~ ~ ~ ~ ~ ~ ~ ~ ~ ~},
    %w{~ ~ ~ ~ ~ ~ ~ ~ ~ ~},
    %w{~ ~ ~ ~ ~ ~ ~ ~ ~ ~},
    %w{~ ~ ~ ~ ~ ~ ~ ~ ~ ~}
  ]

  class << self
    def to_s
      strings = GRID.clone

      # Adds row indicators along top of board
      strings.insert(0, ((1..10).to_a))

      strings.map.with_index do |array, index|
        cloned_array = array.clone 

      # Adds column indicators along game board
        column_reference = ('A'..'G').to_a.insert(0, "*")
        cloned_array.insert(0, (column_reference[index]))

        cloned_array.join("  ")
      end.join("\n")
    end

    # checks board to see if target is a valid ship, returning its value.
    def play(position)
      row = get_row(position)
      column = get_column(position)
      target = BOARD_KEY[GRID[row][column]]
      target.hit if target
      target
    end

    def all_ships
      [BATTLESHIP, DESTROYER, CRUISER, SUBMARINE]
    end

    def remaining_ships
      all_ships.select { |ship| ship.alive? }
    end

    def randomly_place_all_ships
      all_ships.each do |ship|
        randomly_place_ship(ship)
      end
    end

    def valid_coordinate?(guess)
      return false if guess.empty?
      row = get_row(guess)
      column = get_column(guess)
      valid_row?(row) && valid_column?(column)
    end

    private
    def randomly_place_ship(ship)
      positions = get_random_ship_positions(ship)
      place_ship_on_board(ship, positions)
    end


    def get_random_ship_positions(ship)
      end_position = [random_row, random_column]
      positions = []
      direction = random_direction

      until ship.length == positions.size do

        case direction
        when 'up'
          end_position[0] += 1
        when 'down'
          end_position[0] -= 1
        when 'right'
          end_position[1] += 1
        when 'left'
          end_position[1] -= 1
        end
        break unless position_empty?(end_position)
        positions << end_position.clone
      end

      # Checks to see if it has enough valid positions to place the full ship
      # Calling itself again to start the process over if not
      positions = get_random_ship_positions(ship) unless ship.length == positions.size
      positions
    end
    
    def place_ship_on_board(ship, positions)
      positions.each do |coordinates|
        GRID[coordinates[0]][coordinates[1]] = ship.symbol
      end
    end

    def random_direction
      ["up", "down", "left", "right"].sample
    end

    def random_position
      random_row + random_column.to_s
    end

    def random_row
      (0..6).to_a.sample
    end

    def random_column
      (0..9).to_a.sample
    end

    def position_empty?(pos) 
      return false unless valid_row?(pos[0]) && valid_column?(pos[1])
      GRID[pos[0]][pos[1]] == "~"
    end

    def get_row(position)
      letters_hash[position[0]]
    end

    def letters_hash
      letters = ('A'..'G').to_a
      letters.reduce({}) do |hash, letter|
        hash[letter] = letters.index(letter)
        hash
      end
    end

    def get_column(position)
      position[1..-1].to_i - 1
    end

    def valid_row?(row)
      (0..6).include?(row)
    end

    def valid_column?(column)
      (MIN_X..MAX_X).include?(column)
    end

  end
end
