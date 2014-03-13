require 'colorize'
BOARD_SIZE = 8
CHECKER_ROWS = 3

class Board
  attr_accessor :grid

  def grid
    @grid
  end

  def grid=(thing)
    @grid = thing
  end

  def initialize(fill = true)
    setup_grid(fill)
  end



  def setup_grid(fill)
    self.grid = Array.new(BOARD_SIZE) { Array.new(BOARD_SIZE) }

    if fill
        offset = 1
        #fill first 3 rows
        self.grid[0..CHECKER_ROWS].each_with_index do |row, i|
          setup_row(row, i, :B, offset)
          offset = (offset == 1 ? 0 : 1)
        end
        #fill last 3 rows
        offset = 0
        self.grid[(BOARD_SIZE - CHECKER_ROWS)...BOARD_SIZE].each_with_index do |row, i|
          setup_row(row, i, :R, offset)
          offset = (offset == 1 ? 0 : 1)
        end
    end
  end

  def setup_row(row, rownum, color, offset = 0)

    place_piece = true
    #debugger
    (offset...BOARD_SIZE).each do |i|
      if place_piece
        puts "rownum: #{rownum}, i: #{i}"
        self[[rownum, i]] = Piece.new([rownum, i], color)
      end
      place_piece = (place_piece == true ? false : true)
    end

    row
  end

  def color_board
    #background gray and red, pieces black and whitte
  end

  def valid_pos?(pos)
    x, y = pos[0], pos[1]
    return false if x < 0 || x >= BOARD_SIZE || y < 0 || y >= BOARD_SIZE
    true
  end

  def [](pos)
    raise "invalid pos" unless valid_pos?(pos)
    row, col = pos
    #uses the grid method to return the location the instance var points to
    #by fetching grid[row] and finding row[col]
    grid[row][col]
  end

  def []=(pos, piece)
    #debugger
    raise "invalid pos" unless valid_pos?(pos)
    row, col = pos
    #fetches grid[row] using grid method to access instance var
    #uses the []= of Array on that row (which is an array) for col
    grid[row][col] = piece
  end
end