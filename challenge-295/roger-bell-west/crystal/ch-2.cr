#! /usr/bin/crystal

def jumpgame(a)
  target = a.size - 1
  moves = 0
  here = Set(Int32).new
  here.add(0)
  while true
    moves += 1
    there = Set(Int32).new
    here.each do |n|
      (n+1).upto([n + a[n], target].min).each do |i|
        there.add(i)
      end
    end
    if there.size == 0
      return -1
    end
    if there.includes?(target)
      return moves
    end
    here = there
  end
end

require "spec"
describe "jumpgame" do
  it "test_ex1" do
    jumpgame([2, 3, 1, 1, 4]).should eq 2
  end
  it "test_ex2" do
    jumpgame([2, 3, 0, 4]).should eq 2
  end
  it "test_ex3" do
    jumpgame([2, 0, 0, 4]).should eq -1
  end
end
