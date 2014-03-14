class Piece
  attr_accessor :king, :position, :kill_count
  attr_reader :color, :board

  def initialize(position, board, color)
    @position = position
    @color = color
    @board = board
    @kill_count = 0
  end

  def direction_to_position(dir)
    row_mod = 1 if dir[0] == 'd'
    row_mod = -1 if dir[0] == 'u'
    col_mod = -1 if dir[1] == 'l'
    col_mod = 1 if dir[1] == 'r'

    if dir[2] == 'j'
      row_mod *= 2
      col_mod *= 2
    end
    #raise InvalidInputError "l or r" if  !(dir == 'l' || dir == 'r')
    row, col = self.position[0], self.position[1]

    [row + row_mod, col + col_mod]
  end

  def perform_slide(dir) #takes in a left or right
    #find a way to do something 'if no error'
    return false unless valid_if_not_king?(dir)
    end_pos = direction_to_position(dir)

    if !board[end_pos].nil?
      return false
      raise InvalidSelectionError "Piece in way"
    end

    old_pos = self.position
    board[end_pos] = self
    self.position = end_pos
    board[old_pos] = nil

    maybe_promote
    #remove later
    board.render
    true
  end

  def valid_if_not_king?(dir)
    if (dir[0] == 'u' && color == :B && !king)
      return false
      raise InvalidSelectionError "B can't go up unless King"
    end

    if (dir[0] == 'd' && color == :R && !king)
      return false
      raise InvalidSelectionError "R can't go down unless King"
    end

    true

  end

  def perform_jump(dir)
    #debugger
    return false unless valid_if_not_king?(dir)
    end_pos = direction_to_position(dir)
    jumped_pos = direction_to_position(dir[0..1])
    return false if !board[end_pos].nil?
    return false if board[jumped_pos].nil? || board[jumped_pos].color == color

    old_pos = self.position
    board[end_pos] = self
    self.position = end_pos
    board[old_pos] = nil
    board[jumped_pos] = nil
    @kill_count += 1
    maybe_promote
    board.render
    true
  end

  def maybe_promote
    @king = true if (color == :R && position[0] == 0) ||
                      (color == :B && position[0] == 7)
  end

  def to_s
    return ' B' if king && color == :B
    return ' R'.colorize(:red) if king && color == :R
    return ' b' if color == :B
    return ' r'.colorize(:red) if color == :R
  end
end

class InvalidSelectionError < StandardError

end
