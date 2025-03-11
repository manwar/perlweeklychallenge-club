#! /usr/bin/crystal

def transfer(a, b)
  ac = a.ord
  bc = b.ord
  [(ac - bc + 26) % 26, (bc - ac + 26) % 26].min
end

def minimumtime(a)
  tot = a.size
  prev = 'a'
  a.chars.each do |c|
    tot += transfer(prev, c)
    prev = c
  end
  tot
end

require "spec"
describe "minimumtime" do
  it "test_ex1" do
    minimumtime("abc").should eq 5
  end
  it "test_ex2" do
    minimumtime("bza").should eq 7
  end
  it "test_ex3" do
    minimumtime("zjpc").should eq 34
  end
end
