require "sudoku_solver"

describe SudokuSolver do
  
    # Array is unique if no number / character repeats more than once. Empty cell can appear more than once.
  # Empty character ('') & 0 are considered empty. 
  it "checks if an array is unique" do
    @s = SudokuSolver.new
    array1 = [1, 2, 3, 4]
    actual = @s.unique_arr?(array1)
    expect(actual).to be true
  end
  
  it "checks if an array is unique2" do
    @s = SudokuSolver.new
    array1 = [1, 2, 3, 3]
    actual = @s.unique_arr?(array1)
    expect(actual).to be false
  end
  
  it "checks if an array is unique3" do
    @s = SudokuSolver.new
    array1 = [1, 2, 3, '', '']
    actual = @s.unique_arr?(array1)
    expect(actual).to be true
  end
  
  it "checks if all rows in the board are valid" do
    @s = SudokuSolver.new([[0, 0, 0, 0, 0, 0, 0, 0, 5], 
                [0, 0, 0, 0, 0, 0, 0, 0, 0], 
                [0, 3, 0, 0, 0, 0, 0, 0, 0], 
                [0, 0, 0, 0, 0, 0, 0, 0, 0], 
                [0, 0, 0, 0, 0, 0, 0, 0, 0], 
                [0, 0, 0, 0, 0, 0, 0, 0, 0], 
                [0, 0, 0, 0, 0, 0, 0, 0, 0], 
                [0, 3, 0, 0, 0, 0, 0, 0, 0], 
                [0, 3, 0, 0, 0, 0, 0, 0, 0]])
    actual = @s.valid_rows?
    expect(actual).to be true 
  end
  
  it "not all rows are valid" do
    @s = SudokuSolver.new([[1, 0, 0, 0, 0, 0, 0, 0, 5], 
                [0, 0, 0, 4, 0, 0, 0, 0, 0], 
                [0, 0, 0, 0, 0, 0, 0, 0, 0], 
                [0, 0, 0, 0, 0, 0, 0, 0, 0], 
                [0, 0, 0, 0, 0, 0, 0, 0, 0], 
                [0, 0, 0, 0, 0, 0, 0, 0, 0], 
                [0, 0, 0, 0, 0, 0, 0, 0, 0], 
                [0, 0, 0, 0, 0, 0, 0, 0, 0], 
                [0, 3, 0, 0, 0, 0, 4, 3, 0]])
    actual = @s.valid_rows?
    expect(actual).to be false 
  end
  
  it "creates board indicator" do
    @solver = SudokuSolver.new([[0, 0, 0, 0, 0, 0, 0, 0, 5], 
                [0, 0, 0, 0, 0, 0, 0, 0, 0], 
                [0, 2, 0, 0, 0, 0, 0, 0, 0], 
                [0, 0, 0, 0, 0, 0, 0, 0, 0], 
                [0, 0, 0, 0, 0, 0, 0, 0, 0], 
                [0, 0, 0, 0, 0, 0, 0, 0, 0], 
                [0, 0, 0, 0, 0, 0, 0, 0, 0], 
                [0, 7, 0, 0, 0, 0, 0, 0, 0], 
                [0, 3, 0, 0, 0, 0, 0, 0, 0]])
    actual = @solver.create_board_indicator
    expected = 
      [[0, 0, 0, 0, 0, 0, 0, 0, 1], 
      [0, 0, 0, 0, 0, 0, 0, 0, 0], 
      [0, 1, 0, 0, 0, 0, 0, 0, 0], 
      [0, 0, 0, 0, 0, 0, 0, 0, 0], 
      [0, 0, 0, 0, 0, 0, 0, 0, 0], 
      [0, 0, 0, 0, 0, 0, 0, 0, 0], 
      [0, 0, 0, 0, 0, 0, 0, 0, 0], 
      [0, 1, 0, 0, 0, 0, 0, 0, 0], 
      [0, 1, 0, 0, 0, 0, 0, 0, 0]]
    expect(actual).to eq expected 
  end
end