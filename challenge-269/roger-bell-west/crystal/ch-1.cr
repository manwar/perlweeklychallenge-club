#! /usr/bin/crystal

def bitwiseor(a)
  a.select{|n| n % 2 == 0}.size >= 2
end

require "spec"
describe "#tmpl_var name=function>" do
  it "test_ex1" do
    bitwiseor([1, 2, 3, 4, 5]).should eq true
  end
  it "test_ex2" do
    bitwiseor([2, 3, 8, 16]).should eq true
  end
  it "test_ex3" do
    bitwiseor([1, 2, 5, 7, 9]).should eq false
  end
end
