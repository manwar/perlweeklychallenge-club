#! /usr/bin/crystal

def reverseexistence(a)
  c = a.chars.reverse
  c.each_cons(2) do |d|
    sample = "" + d[0] + d[1]
    if !a.index(sample).nil?
      return true
    end
  end
  false
end

require "spec"
describe "reverseexistence" do
  it "test_ex1" do
    reverseexistence("abcba").should eq true
  end
  it "test_ex2" do
    reverseexistence("racecar").should eq true
  end
  it "test_ex3" do
    reverseexistence("abcd").should eq false
  end
  it "test_ex4" do
    reverseexistence("banana").should eq true
  end
  it "test_ex5" do
    reverseexistence("hello").should eq true
  end
end
