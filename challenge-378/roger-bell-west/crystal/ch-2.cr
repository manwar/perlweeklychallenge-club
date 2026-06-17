#! /usr/bin/crystal

def l2n(a)
  a0 = 'a'.ord
  t = 0
  a.chars.each do |c|
    t *= 10
    t += c.ord - a0
  end
  t
end

def sumofwords(a, b, c)
  l2n(a) + l2n(b) == l2n(c)
end

require "spec"
describe "sumofwords" do
  it "test_ex1" do
    sumofwords("acb", "cba", "cdb").should eq true
  end
  it "test_ex2" do
    sumofwords("aab", "aac", "ad").should eq true
  end
  it "test_ex3" do
    sumofwords("bc", "je", "jg").should eq false
  end
  it "test_ex4" do
    sumofwords("a", "aaaa", "aa").should eq true
  end
  it "test_ex5" do
    sumofwords("c", "d", "h").should eq false
  end
  it "test_ex6" do
    sumofwords("gfi", "hbf", "bdhd").should eq true
  end
end
