class Board

  attr_reader :board_arr

  # initialize board
  def initialize(board_arr=nil)
    # set up blank data structure if none given
    @board_arr = board_arr || Board.blank_board
  end

  def self.blank_board
    Array.new(3){Array.new(3)}
  end

  # add players piece to the board
  def add_piece(coords, piece)
    @board_arr[coords[0]][coords[1]] = piece
  end

  def winning_combo?(piece)
    winning_diagonal?(piece)   ||
    winning_horizontal?(piece) ||
    winning_vertical?(piece)
 end

 def winning_diagonal?(piece)
   diagonals.any? do |diag|
     diag.all? {|cell| cell == piece}
   end
 end

 def winning_vertical?(piece)
   verticals.any? do |vert|
      vert.all?{|cell| cell == piece }
    end
  end

  def winning_horizontal?(piece)
    horizontals.any? do |horz|
      horz.all?{|cell| cell == piece }
    end
  end

  def diagonals
   [[ @board_arr[0][0],@board_arr[1][1],@board_arr[2][2] ],[ @board_arr[2][0],@board_arr[1][1],@board_arr[0][2] ]]
  end

  def verticals
    @board_arr
  end

  def horizontals
    horizontals = []
    3.times do |i|
        horizontals << [@board_arr[0][i],@board_arr[1][i],@board_arr[2][i]]
    end
    horizontals
  end

  def full?
    @board_arr.all? do |row|
      row.none?(&:nil?)
    end
  end

end
