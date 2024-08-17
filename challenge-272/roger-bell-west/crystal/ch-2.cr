#! /usr/bin/crystal

def stringscore(a)
  out = 0
  a.chars.each_cons(2) do |c|
    out += (c[0].ord() - c[1].ord()).abs
  end
  out
end

require "spec"
describe "stringscore" do
  it "test_ex1" do
    stringscore("hello").should eq 13
  end
  it "test_ex2" do
    stringscore("perl").should eq 30
  end
  it "test_ex3" do
    stringscore("raku").should eq 37
  end
end
