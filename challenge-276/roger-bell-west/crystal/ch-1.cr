#! /usr/bin/crystal

def completeday(a)
  return a.combinations(2).select{|c| (c[0] + c[1]) % 24 == 0}.size
end

require "spec"
describe "completeday" do
  it "test_ex1" do
    completeday([12, 12, 30, 24, 24]).should eq 2
  end
  it "test_ex2" do
    completeday([72, 48, 24, 5]).should eq 3
  end
  it "test_ex3" do
    completeday([12, 18, 24]).should eq 0
  end
end
