#! /usr/bin/crystal

def maximumaverage(a, n)
  mx = 0
  a.each_cons(n) do |s|
    mx = [mx, s.sum].max
  end
  mx.to_f / n.to_f
end

require "spec"
describe "maximumaverage" do
  it "test_ex1" do
    maximumaverage([1, 12, -5, -6, 50, 3], 4).should eq 12.75
  end
  it "test_ex2" do
    maximumaverage([5], 1).should eq 5
  end
end
