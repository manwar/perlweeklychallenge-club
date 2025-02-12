#! /usr/bin/crystal

def findanagrams(a)
  b = a.map{|x| x.chars.sort.join}
  out = 1
  b.each_cons(2) do |s|
    if s[0] != s[1]
      out += 1
    end
  end
  out
end

require "spec"
describe "findanagrams" do
  it "test_ex1" do
    findanagrams(["acca", "dog", "god", "perl", "repl"]).should eq 3
  end
  it "test_ex2" do
    findanagrams(["abba", "baba", "aabb", "ab", "ab"]).should eq 2
  end
end
