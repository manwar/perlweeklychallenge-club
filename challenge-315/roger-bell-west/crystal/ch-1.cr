#! /usr/bin/crystal

def findwords(a, b)
  out = Array(Int32).new
  a.each_with_index do |x, i|
    if !x.index(b).nil?
      out.push(i)
    end
  end
  out
end

require "spec"
describe "findwords" do
  it "test_ex1" do
    findwords(["the", "weekly", "challenge"], "e").should eq [0, 1, 2]
  end
  it "test_ex2" do
    findwords(["perl", "raku", "python"], "p").should eq [0, 2]
  end
  it "test_ex3" do
    findwords(["abc", "def", "bbb", "bcd"], "b").should eq [0, 2, 3]
  end
end
