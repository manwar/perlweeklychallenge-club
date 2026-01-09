#! /usr/bin/crystal

def shiftgrid(gi, k0)
  wi = Array(Int32).new
  gi.each do |x|
    wi.concat(x)
  end
  k = k0 % wi.size
  wo = wi[wi.size - k .. ]
  wo.concat(wi[0 .. wi.size - k - 1])
  wo.each_slice(gi[0].size).to_a
end

require "spec"
describe "shiftgrid" do
  it "test_ex1" do
    shiftgrid([[1, 2, 3], [4, 5, 6], [7, 8, 9]], 1).should eq [[9, 1, 2], [3, 4, 5], [6, 7, 8]]
  end
  it "test_ex2" do
    shiftgrid([[10, 20], [30, 40]], 1).should eq [[40, 10], [20, 30]]
  end
  it "test_ex3" do
    shiftgrid([[1, 2], [3, 4], [5, 6]], 1).should eq [[6, 1], [2, 3], [4, 5]]
  end
  it "test_ex4" do
    shiftgrid([[1, 2, 3], [4, 5, 6]], 5).should eq [[2, 3, 4], [5, 6, 1]]
  end
  it "test_ex5" do
    shiftgrid([[1, 2, 3, 4]], 1).should eq [[4, 1, 2, 3]]
  end
end
