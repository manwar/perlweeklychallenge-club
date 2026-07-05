#! /usr/bin/crystal

def reversedegree(a)
  t = 0
  z0 = 'z'.ord + 1
  a.chars.each_with_index do |c, i|
    t += (z0 - c.ord) * (1 + i)
  end
  t
end

require "spec"
describe "reversedegree" do
  it "test_ex1" do
    reversedegree("z").should eq 1
  end
  it "test_ex2" do
    reversedegree("a").should eq 26
  end
  it "test_ex3" do
    reversedegree("bbc").should eq 147
  end
  it "test_ex4" do
    reversedegree("racecar").should eq 560
  end
  it "test_ex5" do
    reversedegree("zyx").should eq 14
  end
end
