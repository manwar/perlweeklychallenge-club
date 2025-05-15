#! /usr/bin/crystal

def distinctaverage(a0)
  a = a0.sort
  offset = a.size - 1
  res = Set(Int32).new
  0.upto(a.size / 2 - 1) do |i|
    res.add(a[i] + a[offset - i])
  end
  res.size
end

require "spec"
describe "distinctaverage" do
  it "test_ex1" do
    distinctaverage([1, 2, 4, 3, 5, 6]).should eq 1
  end
  it "test_ex2" do
    distinctaverage([0, 2, 4, 8, 3, 5]).should eq 2
  end
  it "test_ex3" do
    distinctaverage([7, 3, 1, 0, 5, 9]).should eq 2
  end
end
