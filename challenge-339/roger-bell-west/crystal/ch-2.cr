#! /usr/bin/crystal

def peakpoint(a)
  h = 0
  o = 0
  a.each do |p|
    h += p
    o = [o, h].max
  end
  o
end

require "spec"
describe "peakpoint" do
  it "test_ex1" do
    peakpoint([-5, 1, 5, -9, 2]).should eq 1
  end
  it "test_ex2" do
    peakpoint([10, 10, 10, -25]).should eq 30
  end
  it "test_ex3" do
    peakpoint([3, -4, 2, 5, -6, 1]).should eq 6
  end
  it "test_ex4" do
    peakpoint([-1, -2, -3, -4]).should eq 0
  end
  it "test_ex5" do
    peakpoint([-10, 15, 5]).should eq 10
  end
end
