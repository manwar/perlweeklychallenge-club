#! /usr/bin/crystal

def maxoddbinary(a)
  ones = 0
  zeroes = 0
  a.chars.each do |c|
    case c
    when '0'
      zeroes += 1
    when '1'
      ones += 1
    end
  end
  if ones < 1
    return ""
  end
  out = ""
  out += "1" * (ones - 1)
  out += "0" * (zeroes)
  out += '1'
  out
end

require "spec"
describe "maxoddbinary" do
  it "test_ex1" do
    maxoddbinary("1011").should eq "1101"
  end
  it "test_ex2" do
    maxoddbinary("100").should eq "001"
  end
  it "test_ex3" do
    maxoddbinary("111000").should eq "110001"
  end
  it "test_ex4" do
    maxoddbinary("0101").should eq "1001"
  end
  it "test_ex5" do
    maxoddbinary("1111").should eq "1111"
  end
end
