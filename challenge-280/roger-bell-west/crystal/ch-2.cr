#! /usr/bin/crystal
require "spec"
describe "countasterisks" do
  it "test_ex1" do
    countasterisks("p|*e*rl|w**e|*ekly|").should eq 2
  end
  it "test_ex2" do
    countasterisks("perl").should eq 0
  end
  it "test_ex3" do
    countasterisks("th|ewe|e**|k|l***ych|alleng|e").should eq 5
  end
end

def countasterisks(a)
  out = 0
  active = true
  a.chars.each do |c|
    case c
    when '|'
      active = !active
    when '*'
      if active
        out += 1
      end
    end
  end
  out
end
