#! /usr/bin/crystal

def countprefixes(a, b)
  a.select {|x| b.starts_with?(x)}.size
end

require "spec"
describe "countprefixes" do
  it "test_ex1" do
    countprefixes(["a", "ap", "app", "apple", "banana"], "apple").should eq 4
  end
  it "test_ex2" do
    countprefixes(["cat", "dog", "fish"], "bird").should eq 0
  end
  it "test_ex3" do
    countprefixes(["hello", "he", "hell", "heaven", "he"], "hello").should eq 4
  end
  it "test_ex4" do
    countprefixes(["", "code", "coding", "cod"], "coding").should eq 3
  end
  it "test_ex5" do
    countprefixes(["p", "pr", "pro", "prog", "progr", "progra", "program"], "program").should eq 7
  end
end
