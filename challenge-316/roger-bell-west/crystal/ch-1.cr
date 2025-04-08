#! /usr/bin/crystal

def circular(a)
  a.each_cons(2) do |p|
    if p[0][-1] != p[1][0]
        return false
    end
  end
  true
end

require "spec"
describe "circular" do
  it "test_ex1" do
    circular(["perl", "loves", "scala"]).should eq true
  end
  it "test_ex2" do
    circular(["love", "the", "programming"]).should eq false
  end
  it "test_ex3" do
    circular(["java", "awk", "kotlin", "node.js"]).should eq true
  end
end
