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
    begin
      until Board.remaining_ships == []
        report_player_attempts
        user_input = get_position.upcase
        target = player.fire(user_input)
        status_report(target)
      end
    rescue Player::DuplicateTargetError => e
      puts "#{e}, Please try again"
      play
    rescue Board::OffBoardError => e
      puts "#{e}, Please try again"
      play
    rescue Player::NoShotsLeftError => e
      puts Board.to_s
      puts "You lose, No ammo left"
    end
    puts "You win, all ships destroyed" if Board.remaining_ships == [] 
  end

  private
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
