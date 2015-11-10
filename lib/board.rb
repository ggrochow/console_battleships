require 'pry'
class Board
  class OffBoardError < StandardError
  end

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
      row_reference = ('A'..'G').to_a.insert(0, "*")
      strings.insert(0, ((1..10).to_a)) # Adds column indicators
      strings.map.with_index do |array, index|
        cloned_array = array.clone # clones array so attempt_map doenst get modified
        cloned_array.insert(0, (row_reference[index])) # Adds row indicators
        cloned_array.join("  ")
      end.join("\n")
    end

    def play(position)
      row = get_row(position)
      column = get_column(position)
      target = BOARD_KEY[GRID[row][column]]
      target.hit unless target.nil?
      target
    end

    def all_ships
      [BATTLESHIP, DESTROYER, CRUISER, SUBMARINE]
    end

    def remaining_ships
      all_ships.select { |ship| ship.alive? }
    end

    def insert_all_ships
      all_ships.each do |ship|
        insert_ship(ship)
      end
    end

    def valid_coordinate?(guess)
      return false if guess.empty?
      row = get_row(guess)
      column = get_column(guess)
      valid_row?(row) && valid_column?(column)
    end

    private
    def insert_ship(ship)
      positions = nil
      until positions.is_a?(Array)
        positions = get_valid_ship_positions(ship)
      end
      place_ship_on_board(ship, positions)
    end

    def get_valid_ship_positions(ship)
      start_position = [random_row, random_column]
      end_position = start_position
      positions = [start_position]
      direction = random_direction
      ship.length.times do
        case direction
        when 'up'
          end_position[0] += 1
          return false unless position_empty?(end_position)
          positions << end_position.clone
        when 'down'
          end_position[0] -= 1
          return false unless position_empty?(end_position)
          positions << end_position.clone
        when 'right'
          end_position[1] += 1
          return false unless position_empty?(end_position)
          positions << end_position.clone
        when 'left'
          end_position[1] -= 1
          return false unless position_empty?(end_position)
          positions << end_position.clone
        end
      end
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
