#! /usr/bin/crystal
require "spec"
describe "twiceappearance" do
  it "test_ex1" do
    twiceappearance("acbddbca").should eq 'd'
  end
  it "test_ex2" do
    twiceappearance("abccd").should eq 'c'
  end
  it "test_ex3" do
    twiceappearance("abcdabbb").should eq 'a'
  end
end

def twiceappearance(a)
  m = Set(Char).new
  a.chars.each do |c|
    if m.includes?(c)
      return c
    end
    m.add(c)
  end
  return 'x'
end
