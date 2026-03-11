#! /usr/bin/crystal

def decryptstring(a)
  out = ""
  c = a.chars
  s = 0
  while s < c.size
    m = c[s].to_i
    if s + 2 < c.size && c[s + 2] == '#'
      m = m * 10 + c[s + 1].to_i
      s += 2
    end
    s += 1
    out += (96 + m).chr
  end
  out
end

require "spec"
describe "decryptstring" do
  it "test_ex1" do
    decryptstring("10#11#12").should eq "jkab"
  end
  it "test_ex2" do
    decryptstring("1326#").should eq "acz"
  end
  it "test_ex3" do
    decryptstring("25#24#123").should eq "yxabc"
  end
  it "test_ex4" do
    decryptstring("20#5").should eq "te"
  end
  it "test_ex5" do
    decryptstring("1910#26#").should eq "aijz"
  end
end
