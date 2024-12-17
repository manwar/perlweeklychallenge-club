#! /usr/bin/crystal

def nestedarray(a)
  arr = 0
  0.upto(a.size - 1) do |i|
    trail = Set(Int32).new
    j = i
    while true
      j = a[j]
      if trail.includes?(j)
        break
      end
      trail.add(j)
    end
    arr = [arr, trail.size].max
  end
  arr
end
      
require "spec"
describe "nestedarray" do
  it "test_ex1" do
    nestedarray([5, 4, 0, 3, 1, 6, 2]).should eq 4
  end
  it "test_ex2" do
    nestedarray([0, 1, 2]).should eq 1
  end
end
