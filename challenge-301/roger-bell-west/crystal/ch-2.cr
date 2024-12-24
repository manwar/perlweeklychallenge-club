#! /usr/bin/crystal

def hammingdistance(a)
  t = 0
  0.upto(a.size - 2) do |i|
    i.upto(a.size - 1) do |j|
      t += (a[i] ^ a[j]).popcount
    end
  end
  t
end

require "spec"
describe "hammingdistance" do
  it "test_ex1" do
    hammingdistance([4, 14, 2]).should eq 6
  end
  it "test_ex2" do
    hammingdistance([4, 14, 4]).should eq 4
  end
end
