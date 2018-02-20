class Game
  
  attr_accessor :board
  
  MIN_ROW_POSITION = 0
  MAX_ROW_POSITION = 8
  MIN_COL_POSITION = 0
  MAX_COL_POSITION = 8
  
  def initialize (board = [])
    # initialize an empty board
    @board = board
    if @board.empty?
      (0..8).each do |j| 
        empty_row = []
        (0..8).each do |i|
          empty_row.push(0)
        end
        @board.push(empty_row);
      end
    end
  end
  
  def to_array
    [self]
  end
  
  def print_board
    
  end
  
  def add_number(row, col, num)
    @board[row][col] = num
  end
  
    def kuku
        return 'Kuku'
    end
    
  # Checks whether an array is unique.
  # Array is unique if no number / character repeats more than once. Empty cell can appear more than once.
  # Empty character ('') & 0 are considered empty.   
  def unique_arr?(arr)
    not_unique = false
    i = 0
    while (i < arr.length && !not_unique)
      j = i + 1
      while (j < arr.length && !not_unique)
        not_unique = true if arr[i] == arr[j] && arr[i] != '' && arr[i] != 0
        j += 1
      end
      i += 1
    end 
    return !not_unique
  end
  
  # Checks whether all rows in the board are valid
  def valid_rows?
    valid = true
    row = 0
    while (row < @board.length && valid)
      valid = false if !unique_arr?(@board[row])
      row += 1
    end
    valid
  end   
  
  def valid_cols?
    # creating col arrays out of the board
    cols = self.col_arrays
    valid = true
    row = 0
    while (row < cols.length && valid)
     valid = false if !unique_arr?(cols[row])
     row += 1
    end
    valid
  end
  
  # creating col arrays out of the board
  def col_arrays
    #puts self.inspect
    cols = []
    (MIN_ROW_POSITION..MAX_ROW_POSITION).each do |i|
        cols[i] = []
        (MIN_COL_POSITION..MAX_COL_POSITION).each do |j|
          cols[i].push(@board[j][i])
        end
    end 
    cols
  end  
  
  def valid_squares?
    # creating squares array out of the 9 squares
    squares = self.square_arrays
    valid = true
    row = 0
    while (row < squares.length && valid)
      valid = false if !unique_arr?(squares[row])
      row += 1
    end
    valid 
  end    
  
  # creating squares array out of the 9 squares
  def square_arrays
    squares = []
    org_row = 0
    org_col = 0
    (0..8).each do |i|
        squares[i] = []
        (org_row..org_row+2).each do |k|
            (org_col..org_col+2).each do |j|
              squares[i].push(@board[k][j])
            end  
        end
        if org_row == 6
            org_col += 3 
            org_row = 0
        else
            org_row += 3 
        end
    end 
    squares
  end
  
  # Check whether the board is valid
  def valid_board?
    self.valid_rows? && self.valid_cols? && self.valid_squares?
  end
  
  def initialize_empty_board
    board = []
    (MIN_ROW_POSITION..MAX_ROW_POSITION).each do |j| 
      empty_row = []
      (MIN_COL_POSITION..MAX_COL_POSITION).each do |i|
        empty_row.push(0)
      end
      board.push(empty_row);
    end
    board
  end
  
  # create a a board indicator
  # indicates for each square if it was originally empty or full => 1 for full, 0 for empty
  def create_board_indicator
    board_indicator = initialize_empty_board
    (MIN_ROW_POSITION..MAX_ROW_POSITION).each do |j| 
      (MIN_COL_POSITION..MAX_COL_POSITION).each do |i|
        board_indicator[j][i] = 1 if (@board[j][i] != 0 && @board[j][i] != '')
      end
    end
    board_indicator
  end
  
  def solve_the_board
    board_indicator = create_board_indicator
    k = 0
    j = 0
    forward = true
    while k < 9 && j < 9
      #puts 'row: ' + k.to_s
      #puts 'col: ' + j.to_s
      
      #puts @board.inspect
      #puts "-------------"

      found = false
      # If the square in the original board was empty
      if board_indicator[k][j] == 0
        num = @board[k][j] + 1
        while (!found && num <= 9)
         @board[k][j] = num
         found = self.valid_board?
         num += 1
        end
        
      
        if found
          forward = true
          if j < 8
            j += 1
          else
            j = 0
            k += 1
          end
        else
          forward = false
          @board[k][j] = 0  
          if j > 0
            j -= 1
          else
            j = 8
            k -= 1
          end
        end
      else
        if forward
          if j < 8
            j += 1
          else
            j = 0
            k += 1
          end
        else
          if j > 0
            j -= 1
          else
            j = 8
            k -= 1
          end
          
        end
      end
      
    end
    @board
    
  end
  
  def generate_full_board
    k = 0
    j = 0
    while k < 9 && j < 9
      num = @board[k][j] + 1
      found = false
      
      while (!found && num <= 9)
       @board[k][j] = num
       found = self.valid_board?
       num += 1
      end
      
      if found
       if j < 8
         j += 1
       else
         j = 0
         k += 1
       end
      else
        @board[k][j] = 0  
        if j > 0
          j -= 1
        else
          j = 8
          k -= 1
        end
      end
    end
  end
  
  # Override the "==" to compare content of two instances
  # def ==(o)
  #   board == o.board
  # end

  # def hash
  #   board.hash
  # end
end

class Sudoku

  def hello
    return "Hello! game"
  end
  
end

b1 = Game.new
#puts b1.inspect
b1.add_number(8,8,1)
#puts b1.inspect
puts b1.valid_board?

b2 = Game.new
 b2.generate_full_board
 puts b2.inspect

#b3 = Game.new

b3 = Game.new([[0, 0, 0, 0, 7, 0, 9, 0, 5], 
                [0, 3, 0, 0, 4, 0, 0, 0, 0], 
                [5, 0, 0, 3, 0, 0, 0, 2, 1], 
                [0, 0, 5, 0, 0, 2, 0, 0, 4], 
                [1, 0, 0, 0, 0, 0, 0, 0, 9], 
                [6, 0, 0, 7, 0, 0, 1, 0, 0], 
                [9, 6, 0, 0, 0, 5, 0, 0, 2], 
                [0, 0, 0, 0, 9, 0, 0, 1, 0], 
                [7, 0, 8, 0, 2, 0, 0, 0, 0]])
b3.solve_the_board
puts b3.inspect



[[8, 4, 6, 2, 7, 1, 9, 3, 5], 
 [2, 3, 1, 5, 4, 9, 8, 6, 7], 
 [5, 9, 7, 3, 6, 8, 4, 2, 1], 
 
 [3, 8, 5, 9, 1, 2, 6, 7, 4], 
 [1, 7, 4, 8, 3, 6, 2, 5, 9], 
 [6, 2, 9, 7, 5, 4, 1, 8, 3], 
 
 [9, 6, 3, 1, 8, 5, 7, 4, 2], 
 [4, 5, 2, 6, 9, 7, 3, 1, 8], 
 [7, 1, 8, 4, 2, 3, 5, 9, 6]]