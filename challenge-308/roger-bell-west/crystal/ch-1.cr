#! /usr/bin/crystal

def countcommon(a, b)
  aa = Set.new(a)
  bb = Set.new(b)
  (aa & bb).size
end

require "spec"
describe "countcommon" do
  it "test_ex1" do
    countcommon(["perl", "weekly", "challenge"], ["raku", "weekly", "challenge"]).should eq 2
  end
  it "test_ex2" do
    countcommon(["perl", "raku", "python"], ["python", "java"]).should eq 1
  end
  it "test_ex3" do
    countcommon(["guest", "contribution"], ["fun", "weekly", "challenge"]).should eq 0
  end
end
