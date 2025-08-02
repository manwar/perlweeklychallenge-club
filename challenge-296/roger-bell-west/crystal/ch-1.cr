#! /usr/bin/crystal

def compressedunit(count, letter)
  out = ""
  if count > 1
    out += count.to_s
  end
  out += letter
  out
end

def stringcompression(a)
  out = ""
  lastchar = ""
  count = 0
  a.chars.each do |c|
    if count == 0 || c != lastchar
      if count > 0
        out += compressedunit(count, lastchar)
      end
      lastchar = c
      count = 0
    end
    count += 1
  end
  if count > 0
    out += compressedunit(count, lastchar)
  end
  out
end

def stringdecompression(a)
  out = ""
  count = 0
  a.chars.each do |c|
    if c >= '0' && c <= '9'
      count *= 10
      count += c.to_i
    else
      if count == 0
        count = 1
      end
      out += c.to_s * count
      count = 0
    end
  end
  out
end

require "spec"
describe "stringcompression" do
  it "test_ex1" do
    stringcompression("abbc").should eq "a2bc"
  end
  it "test_ex2" do
    stringcompression("aaabccc").should eq "3ab3c"
  end
  it "test_ex3" do
    stringcompression("abcc").should eq "ab2c"
  end
  it "test_ex4" do
    stringdecompression("a2bc").should eq "abbc"
  end
  it "test_ex5" do
    stringdecompression("3ab3c").should eq "aaabccc"
  end
  it "test_ex6" do
    stringdecompression("ab2c").should eq "abcc"
  end
end
