#! /usr/bin/crystal

def counterify(a)
  cc = Hash(Char, Int32).new(default_value: 0)
  a.each do |x|
    cc[x] += 1
  end
  return cc
end

def oddletters(a)
  c = counterify(a.chars)
  c.values.all? { |v| v % 2 == 1 }
end

require "spec"
describe "oddletters" do
  it "test_ex1" do
    oddletters("weekly").should eq false
  end
  it "test_ex2" do
    oddletters("perl").should eq true
  end
  it "test_ex3" do
    oddletters("challenge").should eq false
  end
end
