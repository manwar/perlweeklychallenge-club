#! /usr/bin/crystal

def cleardigits(a)
  out = Array(Char).new
  a.chars.each do |c|
    if c >= '0' && c <= '9'
      out.pop
    else
      out.push(c)
    end
  end
  out.join("")
end

require "spec"
describe "cleardigits" do
  it "test_ex1" do
    cleardigits("cab12").should eq "c"
  end
  it "test_ex2" do
    cleardigits("xy99").should eq ""
  end
  it "test_ex3" do
    cleardigits("pa1erl").should eq "perl"
  end
end
