#! /usr/bin/crystal

def binaryprefix(a)
  c = 0
  out = Array(Bool).new
  a.each do |n|
    c *= 2
    c += n
    out.push(c % 5 == 0)
  end
  out
end

require "spec"
describe "binaryprefix" do
  it "test_ex1" do
    binaryprefix([0, 1, 1, 0, 0, 1, 0, 1, 1, 1]).should eq [true, false, false, false, false, true, true, false, false, false]
  end
  it "test_ex2" do
    binaryprefix([1, 0, 1, 0, 1, 0]).should eq [false, false, true, true, false, false]
  end
  it "test_ex3" do
    binaryprefix([0, 0, 1, 0, 1]).should eq [true, true, false, false, true]
  end
  it "test_ex4" do
    binaryprefix([1, 1, 1, 1, 1]).should eq [false, false, false, true, false]
  end
  it "test_ex5" do
    binaryprefix([1, 0, 1, 1, 0, 1, 0, 0, 1, 1]).should eq [false, false, true, false, false, true, true, true, false, false]
  end
end
