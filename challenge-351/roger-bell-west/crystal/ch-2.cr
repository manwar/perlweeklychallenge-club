#! /usr/bin/crystal

def arithmeticprogression(a0)
  epsilon = 0.001
  a = a0.sort
  delta = a[1] - a[0]
  a.skip(1).each_slice(2) do |v|
    if (v[1] - v[0] - delta).abs > epsilon
      return false
    end
  end
  true
end

require "spec"
describe "arithmeticprogression" do
  it "test_ex1" do
    arithmeticprogression([1, 3, 5, 7, 9]).should eq true
  end
  it "test_ex2" do
    arithmeticprogression([9, 1, 7, 5, 3]).should eq true
  end
  it "test_ex3" do
    arithmeticprogression([1, 2, 4, 8, 16]).should eq false
  end
  it "test_ex4" do
    arithmeticprogression([5, -1, 3, 1, -3]).should eq true
  end
  it "test_ex5" do
    arithmeticprogression([1.5, 3, 0, 4.5, 6]).should eq true
  end
end
