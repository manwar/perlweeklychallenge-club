#! /usr/bin/crystal

def incrementdecrement(operations)
  p = 0
  operations.each do |s|
    if s.chars()[1] == '+'
      p += 1
    else
      p -= 1
    end
  end
  p
end

require "spec"
describe "incrementdecrement" do
  it "test_ex1" do
    incrementdecrement(["--x", "x++", "x++"]).should eq 1
  end
  it "test_ex2" do
    incrementdecrement(["x++", "++x", "x++"]).should eq 3
  end
  it "test_ex3" do
    incrementdecrement(["x++", "++x", "--x", "x--"]).should eq 0
  end
end
