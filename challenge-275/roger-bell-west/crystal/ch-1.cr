#! /usr/bin/crystal

def brokenkeys(a, k)
  out = 0
  failset = Set.new(k.map{ |c| c.downcase })
  a.split(" ").each do |word|
    wordset = Set.new(word.downcase.split(""))
    if (wordset & failset).size == 0
      out += 1
    end
  end
  out
end

require "spec"
describe "brokenkeys" do
  it "test_ex1" do
    brokenkeys("Perl Weekly Challenge", ["l", "a"]).should eq 0
  end
  it "test_ex2" do
    brokenkeys("Perl and Raku", ["a"]).should eq 1
  end
  it "test_ex3" do
    brokenkeys("Well done Team PWC", ["l", "o"]).should eq 2
  end
end
