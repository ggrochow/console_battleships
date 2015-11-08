class Ship

  attr_reader :length, :max_hits, :hits

  def initialize(length, max_hits)
    @length = length
    @max_hits = max_hits
    @hits = 0
  end

  def hit
    @hits += 1
  end

  def alive?
    hits < max_hits
  end
end
