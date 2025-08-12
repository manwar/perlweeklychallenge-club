#! /usr/bin/crystal

def rangesum(a, s, e)
  a[s .. e].sum
end

require "spec"
describe "rangesum" do
  it "test_ex1" do
    rangesum([-2, 0, 3, -5, 2, -1], 0, 2).should eq 1
  end
  it "test_ex2" do
    rangesum([1, -2, 3, -4, 5], 1, 3).should eq -3
  end
  it "test_ex3" do
    rangesum([1, 0, 2, -1, 3], 3, 4).should eq 2
  end
  it "test_ex4" do
    rangesum([-5, 4, -3, 2, -1, 0], 0, 3).should eq -2
  end
  it "test_ex5" do
    rangesum([-1, 0, 2, -3, -2, 1], 0, 2).should eq 1
  end
end
