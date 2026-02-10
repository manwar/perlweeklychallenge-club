#! /usr/bin/crystal

def textjustifier(intxt, width)
  working = Array.new(size: width, value: '*')
  offset = ((width - intxt.size) / 2).to_i
  intxt.chars().each_with_index do |c, i|
    working[i + offset] = c
  end
  working.join("")
end

require "spec"
describe "textjustifier" do
  it "test_ex1" do
    textjustifier("Hi", 5).should eq "*Hi**"
  end
  it "test_ex2" do
    textjustifier("Code", 10).should eq "***Code***"
  end
  it "test_ex3" do
    textjustifier("Hello", 9).should eq "**Hello**"
  end
  it "test_ex4" do
    textjustifier("Perl", 4).should eq "Perl"
  end
  it "test_ex5" do
    textjustifier("A", 7).should eq "***A***"
  end
  it "test_ex6" do
    textjustifier("", 5).should eq "*****"
  end
end
