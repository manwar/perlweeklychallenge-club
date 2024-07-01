#! /usr/bin/crystal

def maximumfrequency(a)
  c = Hash(Int32, Int32).new(default_value: 0)
  a.each do |w|
    c[w] += 1
  end
  mx = c.values.max
  return c.values.select{|v| v == mx}.size * mx
end

require "spec"
describe "maximumfrequency" do
  it "test_ex1" do
    maximumfrequency([1, 2, 2, 4, 1, 5]).should eq 4
  end
  it "test_ex2" do
    maximumfrequency([1, 2, 3, 4, 5]).should eq 5
  end
end
