#! /usr/bin/crystal

require "big"

def rationalnumbers(a, b)
  str2rat(a) == str2rat(b)
end

def str2rat(a)
  fixedpart = ""
  repeatpart = ""
  if (a =~ /^(.*)\((.*)\)$/)
    fixedpart = $1
    repeatpart = $2
  else
    fixedpart = a
    repeatpart = "0"
  end
  point = fixedpart.index(".").not_nil!
  tens = fixedpart.size - point - 1
  n = fixedpart[.. (point - 1)]  + fixedpart[(point + 1) ..]
  v = BigRational.new(n.to_big_i, (10 ** tens).to_big_i)
  repeatd = (10 ** repeatpart.size) - 1
  w = BigRational.new(repeatpart.to_big_i, ((10 ** tens) * repeatd).to_big_i)
  v + w
end

require "spec"
describe "rationalnumbers" do
  it "test_ex1" do
    rationalnumbers("0.(12)", "0.(121)").should eq false
  end
  it "test_ex2" do
    rationalnumbers("0.1(23)", "0.12(32)").should eq true
  end
  it "test_ex3" do
    rationalnumbers("0.1(234)", "0.12(342)").should eq true
  end
  it "test_ex4" do
    rationalnumbers("12.99(99)", "13.").should eq true
  end
  it "test_ex5" do
    rationalnumbers("0.(123)", "0.1(231)").should eq true
  end
end
