#! /usr/bin/crystal

def divisibleaverage(a)
  b = a.select{ |x| x % 6 == 0}
  if b.size == 0
    return 0
  end
  (b.sum.to_f / b.size.to_f + 0.5).to_i
end

require "spec"
describe "divisibleaverage" do
  it "test_ex1" do
    divisibleaverage([18, 5, 7, 11]).should eq 18
  end
  it "test_ex2" do
    divisibleaverage([6, 12, 18, 24, 30, 40]).should eq 18
  end
  it "test_ex3" do
    divisibleaverage([3, 9, 15, 21, 27]).should eq 0
  end
  it "test_ex4" do
    divisibleaverage([6, 12, 14, 20]).should eq 9
  end
  it "test_ex5" do
    divisibleaverage([6, 6, 6, 12, 12]).should eq 8
  end
end
