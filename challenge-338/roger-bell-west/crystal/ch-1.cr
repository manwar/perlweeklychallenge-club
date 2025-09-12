#! /usr/bin/crystal

def highestrow(a)
  a.map{|x| x.sum}.max
end

require "spec"
describe "highestrow" do
  it "test_ex1" do
    highestrow([[4, 4, 4, 4], [10, 0, 0, 0], [2, 2, 2, 9]]).should eq 16
  end
  it "test_ex2" do
    highestrow([[1, 5], [7, 3], [3, 5]]).should eq 10
  end
  it "test_ex3" do
    highestrow([[1, 2, 3], [3, 2, 1]]).should eq 6
  end
  it "test_ex4" do
    highestrow([[2, 8, 7], [7, 1, 3], [1, 9, 5]]).should eq 17
  end
  it "test_ex5" do
    highestrow([[10, 20, 30], [5, 5, 5], [0, 100, 0], [25, 25, 25]]).should eq 100
  end
end
