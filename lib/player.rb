class Player
  class NoShotsLeftError < StandardError
  end
  class DuplicateTargetError < StandardError
  end

  MAX_SHOTS = 25

  attr_reader :shots_fired, :hits, :misses, :attempt_map

    def initialize
      @shots_fired = 0
      @hits = []
      @misses = []
      @attempt_map = Array.new(7) { Array.new(10, '~') }
    end

    def fire(coordinate)
      if can_fire?(coordinate) && new_target?(coordinate)
        # Gets target from board, either nil / ship object
        target = Board.play(coordinate)
        @shots_fired += 1
        # misses return nil 
        if target
          add_hit(coordinate, target)
        else
          add_miss(coordinate)
        end
        target
      else
        false
      end
    end

    def display_attempts
      strings = attempt_map.clone
      
      # Generates and inserts row indicators to board      
      strings.insert(0, ((1..10).to_a)) 

      strings.map.with_index do |array, index|
        cloned_array = array.clone

        # Generates and inserts column indicators to board
        column_reference = ('A'..'G').to_a.insert(0, "*")
        cloned_array.insert(0, (column_reference[index])) 
        cloned_array.join("  ")
      end.join("\n")
    end

    def shots_remaining
      MAX_SHOTS - shots_fired
    end

    def shots_left?
      shots_fired < MAX_SHOTS
    end

    private

    def all_shots
      hits + misses
    end

    def can_fire?(coordinate)
      shots_left? && new_target?(coordinate)
    end

    def add_hit(coordinate, target)
      row = get_row(coordinate)
      column = get_column(coordinate)
      @hits << coordinate
      attempt_map[row][column] = target.symbol
    end

    def add_miss(coordinate)
      row = get_row(coordinate)
      column = get_column(coordinate)
      @misses << coordinate
      attempt_map[row][column] = "x"
    end

    # Generates a hash of with letters corresponding to their respective index value
    def row_hash
      letters = ('A'..'G').to_a
      letters.reduce({}) do |hash, letter|
        hash[letter] = letters.index(letter)
        hash
      end
    end

    # Coordinates are passed in as a string ex: "A5" A returns the row
    def get_row(coordinate)
      row_hash[coordinate[0]]
    end

    # Covers case of play on the 10th col
    def get_column(coordinate)
      coordinate[1..-1].to_i - 1
    end

    def new_target?(coordinate)
      !all_shots.include?(coordinate)
    end
end
