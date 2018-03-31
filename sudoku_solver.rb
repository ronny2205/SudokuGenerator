class SudokuSolver
    
  attr_accessor :board
  
  MIN_ROW_POSITION = 0
  MAX_ROW_POSITION = 8
  MIN_COL_POSITION = 0
  MAX_COL_POSITION = 8
  
  LOWEST_DIGIT = 1
  HIGHEST_DIGIT = 9
  
  def initialize (board = [])
    # initialize an empty board
    @board = board
    if @board.empty?
      (0..MAX_ROW_POSITION).each do |j| 
        empty_row = []
        (0..MAX_COL_POSITION).each do |i|
          empty_row.push(0)
        end
        @board.push(empty_row)
      end
    end
    
    @board_indicator = create_board_indicator
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
  
  def print_board
    (MIN_ROW_POSITION..MAX_ROW_POSITION).each do |j| 
      (MIN_COL_POSITION..MAX_COL_POSITION).each do |i|
        current_num = @board[j][i] == 0 ? ' ' : @board[j][i]
        print current_num
        print ' '
      end
      puts
    end
  end
  
  # create a a board indicator
  # indicates for each square if it was originally empty or full => 1 for full, 0 for empty
  def create_board_indicator
    @row_of_first_empty_square = 0
    @col_of_first_empty_square = 0
    first_empty_square_found = false
    board_indicator = initialize_empty_board
    (MIN_ROW_POSITION..MAX_ROW_POSITION).each do |j| 
      (MIN_COL_POSITION..MAX_COL_POSITION).each do |i|
        if (@board[j][i] == 0 || @board[j][i] == '')
          if !first_empty_square_found
            first_empty_square_found = true
            @row_of_first_empty_square = j
            @col_of_first_empty_square = i
          end
        else
          board_indicator[j][i] = 1
        end
      end
    end
    board_indicator
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
  
  # Solves the board
  #
  # param k - row to start scanning the board from
  # param j - coloumn to start scanning the board from
  def solve_the_board(k = 0, j = 0)
    # check whether the given board was valid
    return false if !self.valid_board?

    forward = true
    while (k <= MAX_ROW_POSITION && j <= MAX_COL_POSITION)
      found = false
      # If the square in the original board was empty
      if @board_indicator[k][j] == 0
        num = @board[k][j] + 1
        while (!found && num <= HIGHEST_DIGIT)
          @board[k][j] = num
          found = self.valid_board?
          num += 1
        end
        
        forward = found
        break if !forward && self.check_if_all_combos_tried(k, j, forward)
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
    # Check whether a solution was found
    if self.valid_board? && !@board.flatten.include?(0)
      return @board
    else
      return false
    end
  end
  
  def check_if_all_combos_tried(row, col, forward)
    if @board_indicator[row][col] == 0 && @board[row][col] == 9 && row == @row_of_first_empty_square && col == @col_of_first_empty_square
      return true
    else
      return false
    end
  end
  
  
  def check_whether_has_more_than_one_solution
    second_solution = solve_the_board(8, 8)
    if !second_solution
      return false
    else
      return true
    end
  end
  
end