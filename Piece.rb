class Piece
  attr_accessor :king, :position
  attr_reader :color, :board

  def initialize(position, board, color)
    @position = position
    @color = color
    @board = board
  end

  def translate_move_direction(dir)


    col_mod = -1 if dir[1] == 'l'
    col_mod = 1 if dir[1] == 'r'
    row_mod = 1 if dir[0] == 'd'
    row_mod = -1 if dir[0] == 'u'

    #raise InvalidInputError "l or r" if  !(dir == 'l' || dir == 'r')

    row, col = self.position[0], self.position[1]

    [row + row_mod, col + col_mod]
  end

  def perform_slide(dir) #takes in a left or right
    #find a way to do something 'if no error'
    valid_if_not_king?(dir)
    end_pos = translate_move_direction(dir)

    raise InvalidSelectionError "Piece in way" if !board[end_pos].nil?
    old_pos = self.position
    board[end_pos] = self
    self.position = end_pos
    board[old_pos] = nil

    #remove later
    board.render
  end

  def valid_if_not_king?(dir)
    if (dir[0] == 'u' && color == :B && !king)
      raise InvalidSelectionError "B can't go up unless King"
    end

    if (dir[0] == 'd' && color == :R && !king)
      raise InvalidSelectionError "R can't go down unless King"
    end

  end

  def perform_jump(end_pos)
    perform(slide)
    #needs to keep track of jump direction
    #and remove jumped piece from the board
  end

  def to_s
    return ' b' if color == :B
    return ' r'.colorize(:red) if color == :R
  end
end

