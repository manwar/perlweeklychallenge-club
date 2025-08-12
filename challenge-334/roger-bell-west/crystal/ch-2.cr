#! /usr/bin/crystal

def nearestvalidpoint(x, y, points)
  ix = -1
  minmhd = -1
  points.each_with_index do |p, i|
    if p[0] == x || p[1] == y
      mhd = (p[0] - x).abs() + (p[1] - y).abs()
      if minmhd == -1 || mhd < minmhd
        minmhd = mhd
        ix = i
      end
    end
  end
  ix
end

require "spec"
describe "nearestvalidpoint" do
  it "test_ex1" do
    nearestvalidpoint(3, 4, [[1, 2], [3, 1], [2, 4], [2, 3]]).should eq 2
  end
  it "test_ex2" do
    nearestvalidpoint(2, 5, [[3, 4], [2, 3], [1, 5], [2, 5]]).should eq 3
  end
  it "test_ex3" do
    nearestvalidpoint(1, 1, [[2, 2], [3, 3], [4, 4]]).should eq -1
  end
  it "test_ex4" do
    nearestvalidpoint(0, 0, [[0, 1], [1, 0], [0, 2], [2, 0]]).should eq 0
  end
  it "test_ex5" do
    nearestvalidpoint(5, 5, [[5, 6], [6, 5], [5, 4], [4, 5]]).should eq 0
  end
end
