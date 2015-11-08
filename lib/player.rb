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
        row = row_hash[coordinate[0]]
        column = coordinate[1..-1].to_i - 1
        if target
            @hits << coordinate
            attempt_map[row][column] = target.symbol
          else
            @misses << coordinate
            attempt_map[row][column] = "X"
         end
        target
      else
        false
      end
    end

    def display_attempts
      attempt_map.map{|arr| arr.join("  ") }.join("\n")
    end

    def shots_remaining
      MAX_SHOTS - shots_fired
    end

    def all_shots
      hits + misses
    end

    private
    def can_fire?(coordinate)
      shots_left? && new_target?(coordinate)
    end

    def row_hash
      letters = ('A'..'G').to_a
      letters.reduce({}) do |hash, letter|
        hash[letter] = letters.index(letter)
        hash
      end
    end

    def shots_left?
      shots_fired < MAX_SHOTS
    end

    def new_target?(coordinate)
      raise DuplicateTargetError, "You've already shot at #{coordinate}" if all_shots.include?(coordinate)
      !all_shots.include?(coordinate)
    end
end

      # all_shots.each do | coordinate |
      #   row = row_hash[coordinate[0]]
      #   column = coordinate[1..-1].to_i - 1
      #   target = Board::GRID[Board.get_row(coordinate)][column]
      #   if target.nil?
      #     attempt_map[row][column] = 'X'
      #   else
      #     attempt_map[row][column] = Board::GRID[Board.get_row(coordinate)][column]
      #   end
      # end
