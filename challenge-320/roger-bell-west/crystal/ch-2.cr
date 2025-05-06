#! /usr/bin/crystal

def sumdifference(a)
  delta = 0
  a.each do |x|
    if x >= 10
      digitsum = 0
      xa = x
      while xa > 0
        xa, y = xa.divmod(10)
        digitsum += y
      end
      delta += x - digitsum
    end
  end
  delta
end

require "spec"
describe "sumdifference" do
  it "test_ex1" do
    sumdifference([1, 23, 4, 5]).should eq 18
  end
  it "test_ex2" do
    sumdifference([1, 2, 3, 4, 5]).should eq 0
  end
  it "test_ex3" do
    sumdifference([1, 2, 34]).should eq 27
  end
end
