#! /usr/bin/crystal

def middleindex(a)
  r = a.sum
  l = 0
  a.each_with_index do |c, i|
    r -= c
    if r == l
      return i
    end
    l += c
  end
  -1
end

require "spec"
describe "middleindex" do
  it "test_ex1" do
    middleindex([2, 3, -1, 8, 4]).should eq 3
  end
  it "test_ex2" do
    middleindex([1, -1, 4]).should eq 2
  end
  it "test_ex3" do
    middleindex([2, 5]).should eq -1
  end
end
