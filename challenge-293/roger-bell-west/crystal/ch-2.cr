#! /usr/bin/crystal

def boomerang(a)
  delta = Array(Tuple(Int32,Int32)).new
  # coincident points
  0.upto(1) do |ij|
    (ij + 1).upto(2) do |ik|
      if a[ij][0] == a[ik][0] && a[ij][1] == a[ik][1]
        return false
      end
    end
    delta.push({a[ij + 1][0] - a[0][0], a[ij + 1][1] - a[0][1]})
  end
  # all on the same vertical line
  if delta[0][0] == 0 && delta[1][0] == 0
    return false
  end
  # just one vertical line
  if delta[0][0] == 0 || delta[1][0] == 0
    return true
  end
  m = Float64.new(delta[0][1]) / Float64.new(delta[0][0])
  c = Float64.new(a[0][1]) - Float64.new(a[0][0]) * m
  Float64.new(a[2][1]) != Float64.new(a[2][0]) * m + c
end

require "spec"
describe "boomerang" do
  it "test_ex1" do
    boomerang([[1, 1], [2, 3], [3, 2]]).should eq true
  end
  it "test_ex2" do
    boomerang([[1, 1], [2, 2], [3, 3]]).should eq false
  end
  it "test_ex3" do
    boomerang([[1, 1], [1, 2], [2, 3]]).should eq true
  end
  it "test_ex4" do
    boomerang([[1, 1], [1, 2], [1, 3]]).should eq false
  end
  it "test_ex5" do
    boomerang([[1, 1], [2, 1], [3, 1]]).should eq false
  end
  it "test_ex6" do
    boomerang([[0, 0], [2, 3], [4, 5]]).should eq true
  end
end
