#! /usr/bin/crystal

def echochamber(a)
  out = ""
  a.split("").each_with_index do |c, i|
    out += c * (i + 1)
  end
  out
end

require "spec"
describe "echochamber" do
  it "test_ex1" do
    echochamber("abca").should eq "abbcccaaaa"
  end
  it "test_ex2" do
    echochamber("xyz").should eq "xyyzzz"
  end
  it "test_ex3" do
    echochamber("code").should eq "coodddeeee"
  end
  it "test_ex4" do
    echochamber("hello").should eq "heelllllllooooo"
  end
  it "test_ex5" do
    echochamber("a").should eq "a"
  end
end
