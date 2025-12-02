#! /usr/bin/crystal

def counterify(a)
  cc = Hash(Char, Int32).new(default_value: 0)
  a.each do |x|
    cc[x] += 1
  end
  return cc
end

def goodsubstrings(a)
  p = 0
  a.chars.each_cons(3) do |s|
    c = counterify(s)
    if c.values.max == 1
      p += 1
    end
  end
  p
end

require "spec"
describe "goodsubstrings" do
  it "test_ex1" do
    goodsubstrings("abcaefg").should eq 5
  end
  it "test_ex2" do
    goodsubstrings("xyzzabc").should eq 3
  end
  it "test_ex3" do
    goodsubstrings("aababc").should eq 1
  end
  it "test_ex4" do
    goodsubstrings("qwerty").should eq 4
  end
  it "test_ex5" do
    goodsubstrings("zzzaaa").should eq 0
  end
end
