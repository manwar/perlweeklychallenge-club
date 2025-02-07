#! /usr/bin/crystal

def checkorder(a)
  b = a.sort
  out = Array(Int32).new
  a.each_with_index do |c, i|
    if b[i] != c
      out.push(i)
    end
  end
  out
end

require "spec"
describe "checkorder" do
  it "test_ex1" do
    checkorder([5, 2, 4, 3, 1]).should eq [0, 2, 3, 4]
  end
  it "test_ex2" do
    checkorder([1, 2, 1, 1, 3]).should eq [1, 3]
  end
  it "test_ex3" do
    checkorder([3, 1, 3, 2, 3]).should eq [0, 1, 3]
  end
end
