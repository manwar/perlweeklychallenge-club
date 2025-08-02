#! /usr/bin/crystal

def baftera(a)
  firstb = a.index('b')
  if firstb.nil?
    return false
  end
  lasta = a.rindex('a')
  if lasta.nil?
    return true
  end
  lasta < firstb
end

require "spec"
describe "" do
  it "test_ex1" do
    baftera("aabb").should eq true
  end
  it "test_ex2" do
    baftera("abab").should eq false
  end
  it "test_ex3" do
    baftera("aaa").should eq false
  end
  it "test_ex4" do
    baftera("bbb").should eq true
  end
end
