#! /usr/bin/crystal

def maxdistance(a, b)
  l1, h1 = a.minmax
  l2, h2 = b.minmax
  [h1 - l2, h2 - l1].max
end

require "spec"
describe "maxdistance" do
  it "test_ex1" do
    maxdistance([4, 5, 7], [9, 1, 3, 4]).should eq 6
  end
  it "test_ex2" do
    maxdistance([2, 3, 5, 4], [3, 2, 5, 5, 8, 7]).should eq 6
  end
  it "test_ex3" do
    maxdistance([2, 1, 11, 3], [2, 5, 10, 2]).should eq 9
  end
  it "test_ex4" do
    maxdistance([1, 2, 3], [3, 2, 1]).should eq 2
  end
  it "test_ex5" do
    maxdistance([1, 0, 2, 3], [5, 0]).should eq 5
  end
end
