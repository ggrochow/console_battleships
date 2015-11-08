class Player
  MAX_SHOTS = 10

  attr_reader :shots_fired, :hits, :misses

    def initialize
      @shots_fired = 0
      @hits = []
      @misses = []
    end

    def fire(coordinate)
      if can_fire?
        target = Board.play(coordinate)
        @shots_fired += 1
        target ? @hits << coordinate : @misses << coordinate
        target
      else
        false
      end
    end

    private
    def can_fire?
      shots_fired < MAX_SHOTS
    end

end
