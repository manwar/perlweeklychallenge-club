#! /usr/bin/crystal

def lastvisitor(a)
  seen = Array(Int32).new
  ans = Array(Int32).new
  minusones = 0
  a.each do |n|
    if n == -1
      minusones += 1
      if minusones <= seen.size
        ans.push(seen[minusones - 1])
      else
        ans.push(-1)
      end
    else
      seen.unshift(n)
      minusones = 0
    end
  end
  ans
end

require "spec"
describe "lastvisitor" do
  it "test_ex1" do
    lastvisitor([5, -1, -1]).should eq [5, -1]
  end
  it "test_ex2" do
    lastvisitor([3, 7, -1, -1, -1]).should eq [7, 3, -1]
  end
  it "test_ex3" do
    lastvisitor([2, -1, 4, -1, -1]).should eq [2, 4, 2]
  end
  it "test_ex4" do
    lastvisitor([10, 20, -1, 30, -1, -1]).should eq [20, 30, 20]
  end
  it "test_ex5" do
    lastvisitor([-1, -1, 5, -1]).should eq [-1, -1, 5]
  end
end
