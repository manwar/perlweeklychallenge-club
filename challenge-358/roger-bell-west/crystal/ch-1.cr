#! /usr/bin/crystal

def strvalue(a)
  n = a.to_i?
  if n.nil?
     n = a.bytesize
  end
  n
end

def maxstrvalue(a)
  a.map {|x| strvalue(x)}.max
end

require "spec"
describe "maxstrvalue" do
  it "test_ex1" do
    maxstrvalue(["123", "45", "6"]).should eq 123
  end
  it "test_ex2" do
    maxstrvalue(["abc", "de", "fghi"]).should eq 4
  end
  it "test_ex3" do
    maxstrvalue(["0012", "99", "a1b2c"]).should eq 99
  end
  it "test_ex4" do
    maxstrvalue(["x", "10", "xyz", "007"]).should eq 10
  end
  it "test_ex5" do
    maxstrvalue(["hello123", "2026", "perl"]).should eq 2026
  end
end
