#! /usr/bin/crystal

def reversebase(a, base)
  digits = Array(Char).new
  c = '0'
  while c <= '9'
    digits.push(c)
    c += 1
  end
  c = 'A'
  while c <= 'Z'
    digits.push(c)
    c += 1
  end
  c = 'a'
  while c <= 'z'
    digits.push(c)
    c += 1
  end
  digits.push('+')
  digits.push('/')
  dd = Hash(Char, Int32).new
  digits.each_with_index do |y, x|
    dd[y] = x
  end
  ov = 0
  a.chars.each do |c|
    ov *= base
    ov += dd[c]
  end
  ov
end

require "spec"
describe "reversebase" do
  it "test_ex1" do
    reversebase("101010", 2).should eq 42
  end
  it "test_ex2" do
    reversebase("EEADEE", 16).should eq 15642094
  end
  it "test_ex3" do
    reversebase("755", 8).should eq 493
  end
  it "test_ex4" do
    reversebase("1BRJB", 36).should eq 2228519
  end
  it "test_ex5" do
    reversebase("7MyqL", 64).should eq 123456789
  end
end
