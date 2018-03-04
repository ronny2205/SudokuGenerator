require "sudoku"

require "json"

RSpec::Matchers.define :be_a_multiple_of do |expected|
  match do |actual|
    actual % expected == 0
  end
end

RSpec::Matchers.define :be_equal_board do |expected|
  match do |actual|
    actual.board == expected.board
  end
end


# describe "the hello function" do
#   it "says hello" do
#     #hello.should == "Hello!"
#     expect(hello).to eq "Hello!"
#   end
# end



describe Game do
  
  # Array is unique if no number / character repeats more than once. Empty cell can appear more than once.
  # Empty character ('') & 0 are considered empty. 
  it "checks if an array is unique" do
    @b = Game.new
    array1 = [1, 2, 3, 4]
    expected = true
    actual = @b.unique_arr?(array1)
    expect(actual).to eq expected
  end
  
  it "checks if an array is unique2" do
    @b = Game.new
    array1 = [1, 2, 3, 3]
    expected = false
    actual = @b.unique_arr?(array1)
    expect(actual).to eq expected
  end
  
  it "checks if an array is unique3" do
    @b = Game.new
    array1 = [1, 2, 3, '', '']
    expected = true
    actual = @b.unique_arr?(array1)
    expect(actual).to eq expected
  end
  
  it "checks if a number is added to the board" do
    @b = Game.new
    @b.add_number(0, 8, 5);
    @b.add_number(8, 1, 3);
    expected = Game.new([[0, 0, 0, 0, 0, 0, 0, 0, 5], 
                [0, 0, 0, 0, 0, 0, 0, 0, 0], 
                [0, 0, 0, 0, 0, 0, 0, 0, 0], 
                [0, 0, 0, 0, 0, 0, 0, 0, 0], 
                [0, 0, 0, 0, 0, 0, 0, 0, 0], 
                [0, 0, 0, 0, 0, 0, 0, 0, 0], 
                [0, 0, 0, 0, 0, 0, 0, 0, 0], 
                [0, 0, 0, 0, 0, 0, 0, 0, 0], 
                [0, 3, 0, 0, 0, 0, 0, 0, 0]])
    #expect(@b).to eq expected
    expect(@b). to be_equal_board expected
  end
  
  it "checks if all rows in the board are valid" do
    @b = Game.new([[0, 0, 0, 0, 0, 0, 0, 0, 5], 
                [0, 0, 0, 0, 0, 0, 0, 0, 0], 
                [0, 3, 0, 0, 0, 0, 0, 0, 0], 
                [0, 0, 0, 0, 0, 0, 0, 0, 0], 
                [0, 0, 0, 0, 0, 0, 0, 0, 0], 
                [0, 0, 0, 0, 0, 0, 0, 0, 0], 
                [0, 0, 0, 0, 0, 0, 0, 0, 0], 
                [0, 3, 0, 0, 0, 0, 0, 0, 0], 
                [0, 3, 0, 0, 0, 0, 0, 0, 0]])
    actual = @b.valid_rows?
    expect(actual).to be true 
  end
  
  it "not all rows are valid" do
    @b = Game.new([[1, 0, 0, 0, 0, 0, 0, 0, 5], 
                [0, 0, 0, 4, 0, 0, 0, 0, 0], 
                [0, 0, 0, 0, 0, 0, 0, 0, 0], 
                [0, 0, 0, 0, 0, 0, 0, 0, 0], 
                [0, 0, 0, 0, 0, 0, 0, 0, 0], 
                [0, 0, 0, 0, 0, 0, 0, 0, 0], 
                [0, 0, 0, 0, 0, 0, 0, 0, 0], 
                [0, 0, 0, 0, 0, 0, 0, 0, 0], 
                [0, 3, 0, 0, 0, 0, 4, 3, 0]])
    actual = @b.valid_rows?
    expect(actual).to be false 
  end
  
  it "checks if all columns in the board are valid" do
    @b = Game.new([[0, 0, 0, 0, 0, 0, 0, 0, 5], 
                [0, 0, 0, 0, 0, 0, 0, 0, 0], 
                [0, 2, 0, 0, 0, 0, 0, 0, 0], 
                [0, 0, 0, 0, 0, 0, 0, 0, 0], 
                [0, 0, 0, 0, 0, 0, 0, 0, 0], 
                [0, 0, 0, 0, 0, 0, 0, 0, 0], 
                [0, 0, 0, 0, 0, 0, 0, 0, 0], 
                [0, 1, 0, 0, 0, 1, 0, 0, 0], 
                [0, 3, 0, 0, 0, 0, 0, 0, 0]])
    actual = @b.valid_cols?
    expect(actual).to be true 
  end
  
  it "Not all columns in the board are valid" do
    @b = Game.new([[0, 0, 0, 0, 0, 0, 0, 0, 5], 
                [0, 0, 0, 0, 0, 0, 0, 0, 0], 
                [0, 2, 0, 0, 0, 0, 0, 0, 0], 
                [0, 0, 0, 0, 0, 0, 0, 0, 5], 
                [0, 0, 0, 0, 0, 0, 0, 0, 0], 
                [0, 0, 0, 0, 0, 0, 0, 0, 0], 
                [0, 0, 0, 0, 0, 0, 0, 0, 0], 
                [0, 1, 0, 0, 0, 1, 0, 0, 0], 
                [0, 3, 0, 0, 0, 0, 0, 0, 0]])
    actual = @b.valid_cols?
    expect(actual).to be false 
  end
  
  it "checks if all squares in the board are valid" do
    @b = Game.new([[0, 0, 0, 0, 0, 0, 0, 0, 5], 
                [0, 0, 0, 0, 0, 0, 0, 0, 0], 
                [0, 2, 0, 0, 0, 0, 0, 0, 0], 
                [0, 0, 0, 0, 0, 0, 0, 0, 0], 
                [0, 0, 0, 0, 0, 0, 0, 0, 0], 
                [0, 0, 0, 0, 0, 0, 0, 0, 0], 
                [0, 0, 0, 0, 0, 0, 0, 0, 0], 
                [0, 1, 0, 0, 0, 1, 0, 0, 0], 
                [0, 3, 0, 0, 0, 0, 0, 0, 0]])
    actual = @b.valid_squares?
    expect(actual).to be true 
  end
  
  it "Not all squares in the board are valid" do
    @b = Game.new([[2, 0, 0, 0, 0, 0, 0, 0, 5], 
                [0, 0, 0, 0, 0, 0, 0, 0, 0], 
                [0, 2, 0, 0, 0, 0, 0, 0, 0], 
                [0, 0, 0, 0, 0, 0, 0, 0, 0], 
                [0, 0, 0, 0, 0, 0, 0, 0, 0], 
                [0, 0, 0, 0, 0, 0, 0, 0, 0], 
                [0, 0, 0, 0, 0, 0, 0, 0, 0], 
                [0, 1, 0, 0, 0, 1, 0, 0, 0], 
                [0, 3, 0, 0, 0, 0, 0, 0, 0]])
    actual = @b.valid_squares?
    expect(actual).to be false 
  end
  
  it "checks whether the board is valid" do
    @b = Game.new([[0, 0, 0, 0, 0, 0, 0, 0, 5], 
                [0, 0, 0, 0, 0, 0, 0, 0, 0], 
                [0, 2, 0, 0, 0, 0, 0, 0, 0], 
                [0, 0, 0, 0, 0, 0, 0, 0, 0], 
                [0, 0, 0, 0, 0, 0, 0, 0, 0], 
                [0, 0, 0, 0, 0, 0, 0, 0, 0], 
                [0, 0, 0, 0, 0, 0, 0, 0, 0], 
                [0, 1, 0, 0, 0, 7, 0, 0, 0], 
                [0, 3, 0, 0, 0, 0, 0, 0, 0]])
    actual = @b.valid_board?
    expect(actual).to be true 
  end
  
  # it "checks whether the board is valid2" do
  #   @b = Game.new(
      
  #       [[1, 2, 3, 4, 5, 6, 7, 8, 9],  
  # [4, 5, 6, 7, 8, 9, 1, 2, 3], 
  # [7, 8, 9, 1, 2, 3, 4, 5, 6], 
  # [2, 1, 4, 3, 6, 5, 8, 9, 7], 
  # [3, 6, 5, 8, 9, 7, 2, 1, 4], 
  # [8, 9, 7, 2, 1, 4, 3, 6, 5], 
  # [5, 3, 1, 6, 4, 2, 9, 7, 8], 
  # [6, 4, 2, 9, 7, 8, 5, 3, 1], 
  # [9, 7, 8, 5, 3, 1, 6, 4, 2]]
     
  #   )
  #   actual = @b.valid_board?
  #   expect(actual).to be true 
  # end
  
  it "checks whether the board is  not valid" do
    @b = Game.new([[0, 2, 0, 0, 0, 0, 0, 0, 5], 
                [0, 0, 0, 0, 0, 0, 0, 0, 0], 
                [0, 2, 0, 0, 0, 0, 0, 0, 0], 
                [0, 0, 0, 0, 0, 0, 0, 0, 0], 
                [0, 0, 0, 0, 0, 0, 0, 0, 0], 
                [0, 0, 0, 0, 0, 0, 0, 0, 0], 
                [0, 0, 0, 0, 0, 0, 0, 0, 0], 
                [0, 1, 0, 0, 0, 7, 0, 0, 0], 
                [0, 3, 0, 0, 0, 0, 0, 0, 0]])
    actual = @b.valid_board?
    expect(actual).to be false 
  end
  
  it "creates board indicator" do
    @b = Game.new([[0, 0, 0, 0, 0, 0, 0, 0, 5], 
                [0, 0, 0, 0, 0, 0, 0, 0, 0], 
                [0, 2, 0, 0, 0, 0, 0, 0, 0], 
                [0, 0, 0, 0, 0, 0, 0, 0, 0], 
                [0, 0, 0, 0, 0, 0, 0, 0, 0], 
                [0, 0, 0, 0, 0, 0, 0, 0, 0], 
                [0, 0, 0, 0, 0, 0, 0, 0, 0], 
                [0, 7, 0, 0, 0, 0, 0, 0, 0], 
                [0, 3, 0, 0, 0, 0, 0, 0, 0]])
    actual = @b.create_board_indicator
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
  
  
  it "solves a board" do 
    @b = Game.new([[1, 2, 3, 4, 5, 6, 7, 8, 0], 
                   [4, 5, 0, 7, 8, 9, 1, 2, 3], 
                   [7, 8, 9, 1, 2, 3, 4, 5, 6], 
                   [2, 1, 4, 3, 6, 5, 8, 9, 7], 
                   [0, 6, 5, 8, 9, 7, 2, 1, 4], 
                   [8, 9, 7, 2, 1, 4, 3, 6, 5], 
                   [5, 3, 1, 6, 4, 2, 9, 7, 8], 
                   [6, 4, 2, 9, 7, 8, 5, 3, 1], 
                   [9, 7, 8, 0, 3, 1, 6, 4, 0]])
    actual = @b.solve_the_board
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
  
  it "finds no solution" do 
    g5 = Game.new(
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
    actual = g5.solve_the_board
    expect(actual).to be false
  
  end
  
end

describe Sudoku do
  it "says hello" do
    @g = Sudoku.new
    expect(@g.hello).to eq "Hello! game"
    
  end
end