#! /usr/bin/crystal

def hasrepeateddigits(a)
  cs = Set(Char).new
  a.to_s.chars.each do |c|
    if cs.includes?(c)
      return true
    end
    cs.add(c)
  end
  false
end

def largestinterval(a)
  v = 1.upto(a).select{|x| !hasrepeateddigits(x)}
  l = Array(Int32).new
  v.each_cons(2) do |d|
    l.push(d[1] - d[0])
  end
  l.max
end

require "spec"
describe "largestinterval" do
  it "test_ex1" do
    largestinterval(20).should eq 2
  end
  it "test_ex2" do
    largestinterval(110).should eq 4
  end
  it "test_ex3" do
    largestinterval(500).should eq 11
  end
  it "test_ex4" do
    largestinterval(2026).should eq 105
  end
  it "test_ex5" do
    largestinterval(10000).should eq 105
  end
end
