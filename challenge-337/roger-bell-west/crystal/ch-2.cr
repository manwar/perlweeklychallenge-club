#! /usr/bin/crystal

def oddmatrix(rows, cols, points)
  rm = Set(Int32).new
  cm = Set(Int32).new
  points.each do |p|
    if rm.includes?(p[0])
      rm.delete(p[0])
    else
      rm.add(p[0])
    end
    if cm.includes?(p[1])
      cm.delete(p[1])
    else
      cm.add(p[1])
    end
  end
  rm.size * (cols - cm.size) +
        cm.size * (rows - rm.size)
end

require "spec"
describe "oddmatrix" do
  it "test_ex1" do
    oddmatrix(2, 3, [[0, 1], [1, 1]]).should eq 6
  end
  it "test_ex2" do
    oddmatrix(2, 2, [[1, 1], [0, 0]]).should eq 0
  end
  it "test_ex3" do
    oddmatrix(3, 3, [[0, 0], [1, 2], [2, 1]]).should eq 0
  end
  it "test_ex4" do
    oddmatrix(1, 5, [[0, 2], [0, 4]]).should eq 2
  end
  it "test_ex5" do
    oddmatrix(4, 2, [[1, 0], [3, 1], [2, 0], [0, 1]]).should eq 8
  end
end
