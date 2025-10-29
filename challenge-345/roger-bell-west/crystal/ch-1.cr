#! /usr/bin/crystal

def peakpositions(a)
  out = Array(Int32).new
  a.each_with_index do |x, i|
    if (i == 0 || x > a[i - 1]) && (i == a.size() - 1 || x > a[i + 1])
      out.push(i)
    end
  end
  out
end

require "spec"
describe "peakpositions" do
  it "test_ex1" do
    peakpositions([1, 3, 2]).should eq [1]
  end
  it "test_ex2" do
    peakpositions([2, 4, 6, 5, 3]).should eq [2]
  end
  it "test_ex3" do
    peakpositions([1, 2, 3, 2, 4, 1]).should eq [2, 4]
  end
  it "test_ex4" do
    peakpositions([5, 3, 1]).should eq [0]
  end
  it "test_ex5" do
    peakpositions([1, 5, 1, 5, 1, 5, 1]).should eq [1, 3, 5]
  end
end
