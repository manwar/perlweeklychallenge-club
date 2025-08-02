#! /usr/bin/crystal

def sortoddeven(a)
  odds = Array(Int32).new
  evens = Array(Int32).new
  a.each_with_index do |x, i|
    if i % 2 == 0
      evens.push(x)
    else
      odds.push(x)
    end
  end
  evens = evens.sort
  odds = odds.sort.reverse
  out = Array(Int32).new
  0.upto([evens.size, odds.size].max) do |i|
    if i < evens.size
      out.push(evens[i])
    end
    if i < odds.size
      out.push(odds[i])
    end
  end
  out
end

require "spec"
describe "sortoddeven" do
  it "test_ex1" do
    sortoddeven([4, 1, 2, 3]).should eq [2, 3, 4, 1]
  end
  it "test_ex2" do
    sortoddeven([3, 1]).should eq [3, 1]
  end
  it "test_ex3" do
    sortoddeven([5, 3, 2, 1, 4]).should eq [2, 3, 4, 1, 5]
  end
end
