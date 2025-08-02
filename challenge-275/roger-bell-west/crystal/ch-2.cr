#! /usr/bin/crystal

def replacedigits(a)
  out = ""
  prev = 0
  a.chars.each do |c|
    out += case c
           when .number?
             (prev + c.to_i).chr
           else
             prev = c.ord
             c
           end
  end
  out
end

require "spec"
describe "replacedigits" do
  it "test_ex1" do
    replacedigits("a1c1e1").should eq "abcdef"
  end
  it "test_ex2" do
    replacedigits("a1b2c3d4").should eq "abbdcfdh"
  end
  it "test_ex3" do
    replacedigits("b2b").should eq "bdb"
  end
  it "test_ex4" do
    replacedigits("a16z").should eq "abgz"
  end
end
