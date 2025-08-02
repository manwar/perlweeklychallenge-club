#! /usr/bin/crystal

def rankarray(a)
  b = a.to_set.to_a.sort
  c = Hash(Int32, Int32).new
  b.each_with_index do |n, i|
    c[n] = i + 1
  end
  out = Array(Int32).new
  a.each do |v|
    out.push(c[v])
  end
  out
end

require "spec"
describe "rankarray" do
  it "test_ex1" do
    rankarray([55, 22, 44, 33]).should eq [4, 1, 3, 2]
  end
  it "test_ex2" do
    rankarray([10, 10, 10]).should eq [1, 1, 1]
  end
  it "test_ex3" do
    rankarray([5, 1, 1, 4, 3]).should eq [4, 1, 1, 3, 2]
  end
end
