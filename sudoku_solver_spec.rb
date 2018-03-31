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
  
  it "checks if all columns in the board are valid" do
    @s = SudokuSolver.new([[0, 0, 0, 0, 0, 0, 0, 0, 5], 
                [0, 0, 0, 0, 0, 0, 0, 0, 0], 
                [0, 2, 0, 0, 0, 0, 0, 0, 0], 
                [0, 0, 0, 0, 0, 0, 0, 0, 0], 
                [0, 0, 0, 0, 0, 0, 0, 0, 0], 
                [0, 0, 0, 0, 0, 0, 0, 0, 0], 
                [0, 0, 0, 0, 0, 0, 0, 0, 0], 
                [0, 1, 0, 0, 0, 1, 0, 0, 0], 
                [0, 3, 0, 0, 0, 0, 0, 0, 0]])
    actual = @s.valid_cols?
    expect(actual).to be true 
  end
  
  it "Not all columns in the board are valid" do
    @s = SudokuSolver.new([[0, 0, 0, 0, 0, 0, 0, 0, 5], 
                [0, 0, 0, 0, 0, 0, 0, 0, 0], 
                [0, 2, 0, 0, 0, 0, 0, 0, 0], 
                [0, 0, 0, 0, 0, 0, 0, 0, 5], 
                [0, 0, 0, 0, 0, 0, 0, 0, 0], 
                [0, 0, 0, 0, 0, 0, 0, 0, 0], 
                [0, 0, 0, 0, 0, 0, 0, 0, 0], 
                [0, 1, 0, 0, 0, 1, 0, 0, 0], 
                [0, 3, 0, 0, 0, 0, 0, 0, 0]])
    actual = @s.valid_cols?
    expect(actual).to be false 
  end
  
  it "checks if all squares in the board are valid" do
    @s = SudokuSolver.new([[0, 0, 0, 0, 0, 0, 0, 0, 5], 
                [0, 0, 0, 0, 0, 0, 0, 0, 0], 
                [0, 2, 0, 0, 0, 0, 0, 0, 0], 
                [0, 0, 0, 0, 0, 0, 0, 0, 0], 
                [0, 0, 0, 0, 0, 0, 0, 0, 0], 
                [0, 0, 0, 0, 0, 0, 0, 0, 0], 
                [0, 0, 0, 0, 0, 0, 0, 0, 0], 
                [0, 1, 0, 0, 0, 1, 0, 0, 0], 
                [0, 3, 0, 0, 0, 0, 0, 0, 0]])
    actual = @s.valid_squares?
    expect(actual).to be true 
  end
  
  it "Not all squares in the board are valid" do
    @s = SudokuSolver.new([[2, 0, 0, 0, 0, 0, 0, 0, 5], 
                [0, 0, 0, 0, 0, 0, 0, 0, 0], 
                [0, 2, 0, 0, 0, 0, 0, 0, 0], 
                [0, 0, 0, 0, 0, 0, 0, 0, 0], 
                [0, 0, 0, 0, 0, 0, 0, 0, 0], 
                [0, 0, 0, 0, 0, 0, 0, 0, 0], 
                [0, 0, 0, 0, 0, 0, 0, 0, 0], 
                [0, 1, 0, 0, 0, 1, 0, 0, 0], 
                [0, 3, 0, 0, 0, 0, 0, 0, 0]])
    actual = @s.valid_squares?
    expect(actual).to be false 
  end
  
  it "checks whether the board is valid" do
    @s = SudokuSolver.new([[0, 0, 0, 0, 0, 0, 0, 0, 5], 
                [0, 0, 0, 0, 0, 0, 0, 0, 0], 
                [0, 2, 0, 0, 0, 0, 0, 0, 0], 
                [0, 0, 0, 0, 0, 0, 0, 0, 0], 
                [0, 0, 0, 0, 0, 0, 0, 0, 0], 
                [0, 0, 0, 0, 0, 0, 0, 0, 0], 
                [0, 0, 0, 0, 0, 0, 0, 0, 0], 
                [0, 1, 0, 0, 0, 7, 0, 0, 0], 
                [0, 3, 0, 0, 0, 0, 0, 0, 0]])
    actual = @s.valid_board?
    expect(actual).to be true 
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
  
  it "checks whether the board is valid" do
    @s = SudokuSolver.new([[0, 0, 0, 0, 0, 0, 0, 0, 5], 
                [0, 0, 0, 0, 0, 0, 0, 0, 0], 
                [0, 2, 0, 0, 0, 0, 0, 0, 0], 
                [0, 0, 0, 0, 0, 0, 0, 0, 0], 
                [0, 0, 0, 0, 0, 0, 0, 0, 0], 
                [0, 0, 0, 0, 0, 0, 0, 0, 0], 
                [0, 0, 0, 0, 0, 0, 0, 0, 0], 
                [0, 1, 0, 0, 0, 7, 0, 0, 0], 
                [0, 3, 0, 0, 0, 0, 0, 0, 0]])
    actual = @s.valid_board?
    expect(actual).to be true 
  end
  
  it "checks whether the board is valid2" do
    @s = SudokuSolver.new(
      
        [[1, 2, 3, 4, 5, 6, 7, 8, 9],  
  [4, 5, 6, 7, 8, 9, 1, 2, 3], 
  [7, 8, 9, 1, 2, 3, 4, 5, 6], 
  [2, 1, 4, 3, 6, 5, 8, 9, 7], 
  [3, 6, 5, 8, 9, 7, 2, 1, 4], 
  [8, 9, 7, 2, 1, 4, 3, 6, 5], 
  [5, 3, 1, 6, 4, 2, 9, 7, 8], 
  [6, 4, 2, 9, 7, 8, 5, 3, 1], 
  [9, 7, 8, 5, 3, 1, 6, 4, 2]]
     
    )
    actual = @s.valid_board?
    expect(actual).to be true 
  end
  
  it "checks whether the board is  not valid" do
    @s = SudokuSolver.new([[0, 2, 0, 0, 0, 0, 0, 0, 5], 
                [0, 0, 0, 0, 0, 0, 0, 0, 0], 
                [0, 2, 0, 0, 0, 0, 0, 0, 0], 
                [0, 0, 0, 0, 0, 0, 0, 0, 0], 
                [0, 0, 0, 0, 0, 0, 0, 0, 0], 
                [0, 0, 0, 0, 0, 0, 0, 0, 0], 
                [0, 0, 0, 0, 0, 0, 0, 0, 0], 
                [0, 1, 0, 0, 0, 7, 0, 0, 0], 
                [0, 3, 0, 0, 0, 0, 0, 0, 0]])
    actual = @s.valid_board?
    expect(actual).to be false 
  end
  
  it "finds no solution" do 
    @s = SudokuSolver.new(
      [[8, 4, 6, 2, 7, 1, 9, 3, 5], 
       [2, 3, 1, 5, 4, 9, 8, 6, 7], 
       [5, 9, 7, 3, 6, 8, 4, 2, 1], 
       [3, 8, 5, 9, 1, 2, 6, 7, 4], 
       [1, 7, 4, 8, 3, 6, 2, 5, 9], 
       [6, 2, 9, 7, 5, 4, 1, 8, 3], 
       [9, 6, 3, 1, 8, 5, 7, 4, 2], 
       [4, 5, 2, 6, 9, 7, 3, 1, 8], 
       [7, 1, 8, 4, 2, 3, 5, 5, 0]]
    )
    actual = @s.solve_the_board
    expect(actual).to be false
  
  end
  
  
  it "solves a board" do 
    @s = SudokuSolver.new([[1, 2, 3, 4, 5, 6, 7, 8, 0], 
                   [4, 5, 0, 7, 8, 9, 1, 2, 3], 
                   [7, 8, 9, 1, 2, 3, 4, 5, 6], 
                   [2, 1, 4, 3, 6, 5, 8, 9, 7], 
                   [0, 6, 5, 8, 9, 7, 2, 1, 4], 
                   [8, 9, 7, 2, 1, 4, 3, 6, 5], 
                   [5, 3, 1, 6, 4, 2, 9, 7, 8], 
                   [6, 4, 2, 9, 7, 8, 5, 3, 1], 
                   [9, 7, 8, 0, 3, 1, 6, 4, 0]])
    actual = @s.solve_the_board
    expected = [[1, 2, 3, 4, 5, 6, 7, 8, 9], 
                [4, 5, 6, 7, 8, 9, 1, 2, 3], 
                [7, 8, 9, 1, 2, 3, 4, 5, 6], 
                [2, 1, 4, 3, 6, 5, 8, 9, 7], 
                [3, 6, 5, 8, 9, 7, 2, 1, 4], 
                [8, 9, 7, 2, 1, 4, 3, 6, 5], 
                [5, 3, 1, 6, 4, 2, 9, 7, 8], 
                [6, 4, 2, 9, 7, 8, 5, 3, 1], 
                [9, 7, 8, 5, 3, 1, 6, 4, 2]]
    expect(actual).to eq expected
  end
  
  it "checks whether a board has more than one solution" do 
    @s = SudokuSolver.new([[1, 2, 3, 4, 5, 6, 7, 8, 0], 
                   [4, 5, 0, 7, 8, 9, 1, 2, 3], 
                   [7, 8, 9, 1, 2, 3, 4, 5, 6], 
                   [2, 1, 4, 3, 6, 5, 8, 9, 7], 
                   [0, 6, 5, 8, 9, 7, 2, 1, 4], 
                   [8, 9, 7, 2, 1, 4, 3, 6, 5], 
                   [5, 3, 1, 6, 4, 2, 9, 7, 8], 
                   [6, 4, 2, 9, 7, 8, 5, 3, 1], 
                   [9, 7, 8, 0, 3, 1, 6, 4, 0]])
    actual = @s.check_whether_has_more_than_one_solution
    expect(actual).to be false
  end
  
  it "checks whether a board has more than one solution2" do 
    @s = SudokuSolver.new
    actual = @s.check_whether_has_more_than_one_solution
    expect(actual).to be true
  end
end