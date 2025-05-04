#! /usr/bin/crystal

def minimumcommon(a, b)
  aa = a.to_set
  bb = b.to_set
  cc = a & b
  if cc.size == 0
    -1
  else
    cc.min
  end
end

require "spec"
describe "minimumcommon" do
  it "test_ex1" do
    minimumcommon([1, 2, 3, 4], [3, 4, 5, 6]).should eq 3
  end
  it "test_ex2" do
    minimumcommon([1, 2, 3], [2, 4]).should eq 2
  end
  it "test_ex3" do
    minimumcommon([1, 2, 3, 4], [5, 6, 7, 8]).should eq -1
  end
end
