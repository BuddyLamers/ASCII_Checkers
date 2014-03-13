class Piece
  attr_accessor :king, :location
  attr_reader :color, :board

  def initialize(location, color)
    @location = location
    @color = color
  end

  def perform_slide

  end

  def perform_jump
    #needs to keep track of jump direction
    #and remove jumped piece from the board
  end

  def inspect
    'B' if color == :B
    'W' if color == :W
  end
end