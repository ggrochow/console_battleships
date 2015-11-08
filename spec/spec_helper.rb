require 'rspec'
require 'pry'
require 'byebug'

def safe_require(file)
  require file
rescue LoadError
  # ignore
end

safe_require 'board'
safe_require 'player'
safe_require 'ship'
safe_require 'cruiser'
safe_require 'battleship'
safe_require 'destroyer'
