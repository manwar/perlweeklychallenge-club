#! /usr/bin/crystal

def wordsorter(a)
  w = a.split
  w.sort_by! { |w| w.downcase }
  w.join(" ")
end

require "spec"
describe "wordsorter" do
  it "test_ex1" do
    wordsorter("The quick brown fox").should eq "brown fox quick The"
  end
  it "test_ex2" do
    wordsorter("Hello    World!   How   are you?").should eq "are Hello How World! you?"
  end
  it "test_ex3" do
    wordsorter("Hello").should eq "Hello"
  end
  it "test_ex4" do
    wordsorter("Hello, World! How are you?").should eq "are Hello, How World! you?"
  end
  it "test_ex5" do
    wordsorter("I have 2 apples and 3 bananas!").should eq "2 3 and apples bananas! have I"
  end
end
