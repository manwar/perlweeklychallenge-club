#! /usr/bin/crystal

def largestsubstring(a)
  cc = a.chars()
  (cc.size - 1).downto(1) do |offset|
    0.upto(cc.size - 1 - offset) do |x|
      if cc[x] == cc[x + offset]
        return offset - 1
      end
    end
  end
  -1
end

require "spec"
describe "largestsubstring" do
  it "test_ex1" do
    largestsubstring("aaaaa").should eq 3
  end
  it "test_ex2" do
    largestsubstring("abcdeba").should eq 5
  end
  it "test_ex3" do
    largestsubstring("abbc").should eq 0
  end
  it "test_ex4" do
    largestsubstring("abcaacbc").should eq 4
  end
  it "test_ex5" do
    largestsubstring("laptop").should eq 2
  end
end
