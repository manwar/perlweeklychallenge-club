#! /usr/bin/crystal

def duplicateremovals(a)
  b = Array(Char).new
  a.chars.each do |c|
    if b.size == 0 || c != b[-1]
      b.push(c)
    else
      b.pop
    end
  end
  b.join("")
end

require "spec"
describe "duplicateremovals" do
  it "test_ex1" do
    duplicateremovals("abbaca").should eq "ca"
  end
  it "test_ex2" do
    duplicateremovals("azxxzy").should eq "ay"
  end
  it "test_ex3" do
    duplicateremovals("aaaaaaaa").should eq ""
  end
  it "test_ex4" do
    duplicateremovals("aabccba").should eq "a"
  end
  it "test_ex5" do
    duplicateremovals("abcddcba").should eq ""
  end
end
