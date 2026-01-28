#! /usr/bin/crystal

def rotx(a, offset)
  o = offset.modulo(26)
  base = 0
  if a >= 'a' && a <= 'z'
    base = 'a'.ord
  elsif a >= 'A' && a <= 'Z'
    base = 'A'.ord
  else
    return a
  end
  c = (a.ord - base + o).modulo(26) + base
  c.chr
end

def encryptedstring(a, offset)
  a.chars.map {|x| rotx(x, offset)}.join("")
end

require "spec"
describe "encryptedstring" do
  it "test_ex1" do
    encryptedstring("abc", 1).should eq "bcd"
  end
  it "test_ex2" do
    encryptedstring("xyz", 2).should eq "zab"
  end
  it "test_ex3" do
    encryptedstring("abc", 27).should eq "bcd"
  end
  it "test_ex4" do
    encryptedstring("hello", 5).should eq "mjqqt"
  end
  it "test_ex5" do
    encryptedstring("perl", 26).should eq "perl"
  end
end
