#! /usr/bin/crystal

def findwinner(a)
  board = [
    [ 0, 0, 0 ],
    [ 0, 0, 0 ],
    [ 0, 0, 0 ]
  ]
  player = 1
  a.each do |play|
    board[play[0]][play[1]] = player
    player = 3 - player
  end
  [
    [0, 0, 1, 0],
    [0, 1, 1, 0],
    [0, 2, 1, 0],
    [0, 0, 0, 1],
    [1, 0, 0, 1],
    [2, 0, 0, 1],
    [0, 0, 1, 1],
    [0, 2, 1, -1],
  ].each do |pattern|
    cellvals = Set(Int32).new
    0.upto(2) do |i|
      x = pattern[0] + i * pattern[2]
      y = pattern[1] + i * pattern[3]
      cellvals.add(board[y][x])
    end
    if cellvals.size == 1
      winner = cellvals.to_a[0]
      if winner == 1
        return "A"
      elsif winner == 2
        return "B"
      end
    end
  end
  if a.size == 9
    return "Draw"
  else
    return "Pending"
  end
end

require "spec"
describe "findwinner" do
  it "test_ex1" do
    findwinner([[0, 0], [2, 0], [1, 1], [2, 1], [2, 2]]).should eq "A"
  end
  it "test_ex2" do
    findwinner([[0, 0], [1, 1], [0, 1], [0, 2], [1, 0], [2, 0]]).should eq "B"
  end
  it "test_ex3" do
    findwinner([[0, 0], [1, 1], [2, 0], [1, 0], [1, 2], [2, 1], [0, 1], [0, 2], [2, 2]]).should eq "Draw"
  end
  it "test_ex4" do
    findwinner([[0, 0], [1, 1]]).should eq "Pending"
  end
  it "test_ex5" do
    findwinner([[1, 1], [0, 0], [2, 2], [0, 1], [1, 0], [0, 2]]).should eq "B"
  end
end
