#! /usr/bin/crystal

def smallergreaterelement(a)
  mn = a.min
  mx = a.max
  return a.select {|x| x > mn && x < mx}.size
end

require "spec"
describe "smallergreaterelement" do
  it "test_ex1" do
    smallergreaterelement([2, 4]).should eq 0
  end
  it "test_ex2" do
    smallergreaterelement([1, 1, 1, 1]).should eq 0
  end
  it "test_ex3" do
    smallergreaterelement([1, 1, 4, 8, 12, 12]).should eq 2
  end
  it "test_ex4" do
    smallergreaterelement([3, 6, 6, 9]).should eq 2
  end
  it "test_ex5" do
    smallergreaterelement([0, -5, 10, -2, 4]).should eq 3
  end
end
