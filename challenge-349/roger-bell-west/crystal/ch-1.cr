#! /usr/bin/crystal

def powerstring(a)
  mx = 0
  prev = 'A'
  cur = 0
  a.chars.each do |c|
    if cur > 0 && c == prev
      cur += 1
    else
      cur = 1
      prev = c
    end
    mx = [mx, cur].max
  end
  mx
end

require "spec"
describe "powerstring" do
  it "test_ex1" do
    powerstring("textbook").should eq 2
  end
  it "test_ex2" do
    powerstring("aaaaa").should eq 5
  end
  it "test_ex3" do
    powerstring("hoorayyy").should eq 3
  end
  it "test_ex4" do
    powerstring("x").should eq 1
  end
  it "test_ex5" do
    powerstring("aabcccddeeffffghijjk").should eq 4
  end
end
