BOARD_SIZE = 8
CHECKER_ROWS = 3

class Board
  attr_accessor :grid
  #
  # def grid
  #   @grid
  # end
  #
  # def grid=(thing)
  #   @grid = thing
  # end

  def initialize(fill = true)
    setup_grid(fill)
  end



  def setup_grid(fill)
    self.grid = Array.new(BOARD_SIZE) { Array.new(BOARD_SIZE) }

    if fill
        offset = 1
        #fill first X rows
        self.grid[0...CHECKER_ROWS].each_with_index do |row, i|
          setup_row(i, :B, offset)
          offset = (offset == 1 ? 0 : 1)
        end
        #fill last X rows
        offset = 0
        (BOARD_SIZE - CHECKER_ROWS).upto((BOARD_SIZE - 1)) do |i|
          puts "I'm doing the second row. I'm on #{i}"
          setup_row(i, :R, offset)
          offset = (offset == 1 ? 0 : 1)
        end
        # self.grid[(BOARD_SIZE - CHECKER_ROWS)...BOARD_SIZE].each_with_index do |row, i|
#           setup_row(row, i, :R, offset)
#           offset = (offset == 1 ? 0 : 1)
#         end
    end
    nil
  end

  def setup_row(rownum, color, offset = 0)

    place_piece = true
    #debugger
    #(offset...BOARD SIZE).each do
   for i in offset...BOARD_SIZE
      if place_piece
        puts "rownum: #{rownum}, i: #{i}"
        self[[rownum, i]] = Piece.new([rownum, i], self, color)
      end
      place_piece = (place_piece == true ? false : true)
    end
    nil
  end

  def render
    row_count = 0
    puts " 0 1 2 3 4 5 6 7"
    bg_col = :grey
    grid.each do |row|
      print row_count.to_s
      row_count += 1
      bg_col = (bg_col == :grey ? :white : :grey)
      row.each do |sq|
        print "  ".colorize(:background => bg_col) if sq.nil?
        print sq.to_s.colorize(:background => bg_col)
        bg_col = (bg_col == :grey ? :white : :grey)
      end
       puts
    end
    nil
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
