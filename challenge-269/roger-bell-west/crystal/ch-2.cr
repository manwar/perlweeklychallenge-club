#! /usr/bin/crystal

def distributeelements(a)
  x = [a[0]]
  y = [a[1]]
  (2 ... a.size).each do |i|
    n = a[i]
    if x[-1] > y[-1]
      x.push(n)
    else
      y.push(n)
    end
  end
  x.concat(y)
  x
end

require "spec"
describe "#tmpl_var name=function>" do
  it "test_ex1" do
    distributeelements([2, 1, 3, 4, 5]).should eq [2, 3, 4, 5, 1]
  end
  it "test_ex2" do
    distributeelements([3, 2, 4]).should eq [3, 4, 2]
  end
  it "test_ex3" do
    distributeelements([5, 4, 3, 8]).should eq [5, 3, 4, 8]
  end
end
