#! /usr/bin/crystal

def reverseprefix(a, f)
  c = a.split("")
  p = a.index(f)
  if !p.nil?
    jr = c[0, p + 1].reverse
    jr.each_with_index do |ch, i|
      c[i] = ch
    end
  end
  c.join("")
end

require "spec"
describe "reverseprefix" do
  it "test_ex1" do
    reverseprefix("programming", "g").should eq "gorpramming"
  end
  it "test_ex2" do
    reverseprefix("hello", "h").should eq "hello"
  end
  it "test_ex3" do
    reverseprefix("abcdefghij", "h").should eq "hgfedcbaij"
  end
  it "test_ex4" do
    reverseprefix("reverse", "s").should eq "srevere"
  end
  it "test_ex5" do
    reverseprefix("perl", "r").should eq "repl"
  end
end
