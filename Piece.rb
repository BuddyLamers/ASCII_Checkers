class Piece
  attr_accessor :king, :location
  attr_reader :color, :board

  def initialize(location, board, color)
    @location = location
    @color = color
    @board = board
  end

  def perform_slide

  end

  def perform_jump
    #needs to keep track of jump direction
    #and remove jumped piece from the board
  end

  def to_s
    return ' b' if color == :B
    return ' r'.colorize(:red) if color == :R
  end
end