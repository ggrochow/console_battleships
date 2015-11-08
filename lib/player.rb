class Player
  class NoShotsLeftError < StandardError
  end
  class DuplicateTargetError < StandardError
  end

  MAX_SHOTS = 20

  attr_reader :shots_fired, :hits, :misses, :attempt_map

    def initialize
      @shots_fired = 0
      @hits = []
      @misses = []
      @attempt_map = Array.new(7) { Array.new(10, '~') }
    end

    def fire(coordinate)
      if can_fire?(coordinate)
        target = Board.play(coordinate)
        @shots_fired += 1
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
      row_reference = ('A'..'G').to_a.insert(0, "*")
      strings.insert(0, ((1..10).to_a)) # Adds column indicators
      strings.map.with_index do |array, index|
        cloned_array = array.clone # clones array so attempt_map doenst get modified
        cloned_array.insert(0, (row_reference[index])) # Adds row indicators
        cloned_array.join("  ")
      end.join("\n")
    end

    def shots_remaining
      MAX_SHOTS - shots_fired
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

    def row_hash
      letters = ('A'..'G').to_a
      letters.reduce({}) do |hash, letter|
        hash[letter] = letters.index(letter)
        hash
      end
    end

    def get_row(coordinate)
      row_hash[coordinate[0]]
    end

    def get_column(coordinate)
      coordinate[1..-1].to_i - 1
    end

    def shots_left?
      raise NoShotsLeftError unless shots_fired < MAX_SHOTS
      shots_fired < MAX_SHOTS
    end

    def new_target?(coordinate)
      raise DuplicateTargetError, "You've already shot at #{coordinate}" if all_shots.include?(coordinate)
      !all_shots.include?(coordinate)
    end
end
