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
        @board.push(empty_row);
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
    
end