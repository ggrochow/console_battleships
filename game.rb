require_relative 'lib/player'
require_relative 'lib/ship'
require_relative 'lib/cruiser'
require_relative 'lib/battleship'
require_relative 'lib/destroyer'
require_relative 'lib/submarine'
require_relative 'lib/board'

class Game

  attr_reader :player

  def initialize
    @player = Player.new
    Board.insert_all_ships
  end

  def play
    until Board.remaining_ships == [] || !player.shots_left?
      play_turn
    end
    if player.shots_left?
      puts "You win, all ships destroyed"
    else 
      puts Board.to_s
      puts "You lose, No ammo left"
    end
  end

  private
  def play_turn
    report_player_attempts
    user_input = get_position.upcase
    unless Board.valid_coordinate?(user_input)
      puts "Play #{user_input} off board"
      return false
    end
    target = player.fire(user_input)
    status_report(target)
  end


  def report_player_attempts
    puts player.display_attempts
  end

  def status_report(target)
  if target
    if target.alive? 
      puts "You hit a #{target.class}, its got #{target.max_hits - target.hits} HP left"
    else
      puts "You hit a #{target.class}, destryoting it! #{Board.remaining_ships.size} ships left"
    end
  else
    puts "You missed, #{player.shots_remaining} shots left"
  end

  end
  def get_position
    puts "Enter the coordinates to shoot at "
    gets.chomp
  end
end

Game.new.play
