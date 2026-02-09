#! /usr/bin/crystal

def digitalroot(a)
  count = 0
  value = a
  while value > 9
    p = 0
    while value > 0
      p += value % 10
      value = value.tdiv(10)
    end
    value = p
    count += 1
  end
  [count, value]
end

require "spec"
describe "digitalroot" do
  it "test_ex1" do
    digitalroot(38).should eq [2, 2]
  end
  it "test_ex2" do
    digitalroot(7).should eq [0, 7]
  end
  it "test_ex3" do
    digitalroot(999).should eq [2, 9]
  end
  it "test_ex4" do
    digitalroot(1999999999).should eq [3, 1]
  end
  it "test_ex5" do
    digitalroot(101010).should eq [1, 3]
  end
end
