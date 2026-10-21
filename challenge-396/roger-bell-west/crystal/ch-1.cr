#! /usr/bin/crystal

def finishingorder(order, friends)
  wanted = friends.to_set
  order.select{|x| wanted.includes?(x)}
end

require "spec"
describe "finishingorder" do
  it "test_ex1" do
    finishingorder([3, 1, 4, 2, 5], [1, 4, 2]).should eq [1, 4, 2]
  end
  it "test_ex2" do
    finishingorder([5, 4, 3, 2, 1], [1, 3, 5]).should eq [5, 3, 1]
  end
  it "test_ex3" do
    finishingorder([2, 4, 1, 3], [1, 2, 3, 4]).should eq [2, 4, 1, 3]
  end
  it "test_ex4" do
    finishingorder([4, 1, 3, 2], [3]).should eq [3]
  end
  it "test_ex5" do
    finishingorder([1, 3, 2, 6, 5, 4], [1, 2, 3]).should eq [1, 3, 2]
  end
end
