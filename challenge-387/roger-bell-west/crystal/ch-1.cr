#! /usr/bin/crystal

def rearrangebinarystring(a0)
  ct = 0
  a = a0
  while true
    b = a.gsub("01", "10")
    if b == a
      break
    else
      a = b
      ct += 1
    end
  end
  ct
end

require "spec"
describe "rearrangebinarystring" do
  it "test_ex1" do
    rearrangebinarystring("111000").should eq 0
  end
  it "test_ex2" do
    rearrangebinarystring("00011").should eq 4
  end
  it "test_ex3" do
    rearrangebinarystring("01011").should eq 3
  end
  it "test_ex4" do
    rearrangebinarystring("010101").should eq 3
  end
  it "test_ex5" do
    rearrangebinarystring("00001").should eq 4
  end
end
