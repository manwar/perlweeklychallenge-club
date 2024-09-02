#! /usr/bin/crystal

def relativesort(list1, list2)
  c = Hash(Int32, Int32).new(default_value: 0)
  list1.each do |n|
    c[n] += 1
  end
  out = [] of Int32
  list2.each do |i|
    out.concat(Array.new(c[i], i))
    c.delete(i)
  end
  d = c.keys.sort
  d.each do |i|
    out.concat(Array.new(c[i], i))
  end
  out
end

require "spec"
describe "relativesort" do
  it "test_ex1" do
    relativesort([2, 3, 9, 3, 1, 4, 6, 7, 2, 8, 5], [2, 1, 4, 3, 5, 6]).should eq [2, 2, 1, 4, 3, 3, 5, 6, 7, 8, 9]
  end
  it "test_ex2" do
    relativesort([3, 3, 4, 6, 2, 4, 2, 1, 3], [1, 3, 2]).should eq [1, 3, 3, 3, 2, 2, 4, 4, 6]
  end
  it "test_ex3" do
    relativesort([3, 0, 5, 0, 2, 1, 4, 1, 1], [1, 0, 3, 2]).should eq [1, 1, 1, 0, 0, 3, 2, 4, 5]
  end
end
