require_relative "sudoku_solver"

class SudokuGenerator
  def initialize
      
    @s = SudokuSolver.new
    
    # Solving an empty board will generate a full valid soduku board
    @s.solve_the_board
    
    @s.print_board
  end
    
end

@g = SudokuGenerator.new