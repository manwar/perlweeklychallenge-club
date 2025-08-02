#! /usr/bin/crystal

def numbergame(a0)
  out = Array(Int32).new
  a = a0.sort
  a.each_slice(2) do |s|
    out.push(s[1])
    out.push(s[0])
  end
  out
end

require "spec"
describe "#tmpl_var name=function>" do
  it "test_ex1" do
    numbergame([2, 5, 3, 4]).should eq [3, 2, 5, 4]
  end
  it "test_ex2" do
    numbergame([9, 4, 1, 3, 6, 4, 6, 1]).should eq [1, 1, 4, 3, 6, 4, 9, 6]
  end
  it "test_ex3" do
    numbergame([1, 2, 2, 3]).should eq [2, 1, 3, 2]
  end
end
