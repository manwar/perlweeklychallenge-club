#! /usr/bin/crystal

def validnumber(a)
  integer = "[-+]?[0-9]+"
  float = "[-+]?([0-9]+\.[0-9]*|[0-9]*\.[0-9]+)"
  exponential =
    "(" + integer + "|" + float + ")[Ee]" + integer
  number =
    "^(" + integer + "|" + float + "|" + exponential + ")$"
  rx = Regex.new(number)
  if rx.match(a)
    return true
  end
  false
end

require "spec"
describe "validnumber" do
  it "test_ex1" do
    validnumber("1").should eq true
  end
  it "test_ex2" do
    validnumber("a").should eq false
  end
  it "test_ex3" do
    validnumber(".").should eq false
  end
  it "test_ex4" do
    validnumber("1.2e4.2").should eq false
  end
  it "test_ex5" do
    validnumber("-1.").should eq true
  end
  it "test_ex6" do
    validnumber("+1E-8").should eq true
  end
  it "test_ex7" do
    validnumber(".44").should eq true
  end
end
