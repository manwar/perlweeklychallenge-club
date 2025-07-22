#! /usr/bin/crystal

def lastword(a)
  w = a.split(" ").select{|x| x.size > 0}
  w[w.size - 1].size
end

require "spec"
describe "lastword" do
  it "test_ex1" do
    lastword("The Weekly Challenge").should eq 9
  end
  it "test_ex2" do
    lastword("   Hello   World    ").should eq 5
  end
  it "test_ex3" do
    lastword("Let's begin the fun").should eq 3
  end
end
