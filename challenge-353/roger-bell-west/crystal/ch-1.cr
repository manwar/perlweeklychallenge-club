#! /usr/bin/crystal

def maxwords(a)
  a.map { |x| x.split(' ').size }.max
end

require "spec"
describe "maxwords" do
  it "test_ex1" do
    maxwords(["Hello world", "This is a test", "Perl is great"]).should eq 4
  end
  it "test_ex2" do
    maxwords(["Single"]).should eq 1
  end
  it "test_ex3" do
    maxwords(["Short", "This sentence has six words in total", "A B C", "Just four words here"]).should eq 7
  end
  it "test_ex4" do
    maxwords(["One", "Two parts", "Three part phrase", ""]).should eq 3
  end
  it "test_ex5" do
    maxwords(["The quick brown fox jumps over the lazy dog", "A", "She sells seashells by the seashore", "To be or not to be that is the question"]).should eq 10
  end
end
