class Game
  attr_accessor :board
  def initialize
    @board = Board.new
  end

  def run

  board.render
  end

end