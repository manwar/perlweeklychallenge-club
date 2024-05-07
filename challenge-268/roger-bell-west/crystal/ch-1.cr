#! /usr/bin/crystal

def magicnumber(a, b)
  b.min - a.min
end

require "spec"
describe "#tmpl_var name=function>" do
  it "test_ex1" do
    magicnumber([3, 7, 5], [9, 5, 7]).should eq 2
  end
  it "test_ex2" do
    magicnumber([1, 2, 1], [5, 4, 4]).should eq 3
  end
  it "test_ex3" do
    magicnumber([2], [5]).should eq 3
  end
end
