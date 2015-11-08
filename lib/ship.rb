class Ship

  attr_reader :length, :max_shots, :hits

  def initialize(length, max_shots)
    @length = length
    @max_shots = max_shots
    @hits = 0
  end

end
