#! /usr/bin/crystal

def closestpalindrome(a)
  n = a.to_i
  delta = -1
  while true
    q = (n + delta).to_s
    if q == q.reverse
      return q
    end
    delta = -delta
    if delta < 0
      delta -= 1
    end
  end
end

require "spec"
describe "closestpalindrome" do
  it "test_ex1" do
    closestpalindrome("123").should eq "121"
  end
  it "test_ex2" do
    closestpalindrome("2").should eq "1"
  end
  it "test_ex3" do
    closestpalindrome("1400").should eq "1441"
  end
  it "test_ex4" do
    closestpalindrome("1000").should eq "999"
  end
end
