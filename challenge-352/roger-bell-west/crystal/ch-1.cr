#! /usr/bin/crystal

def matchstring(a)
  out = Array(String).new
  a.each do |x|
    if !out.any? {|i| x == i}
      a.each do |y|
        if y.size > x.size && y.index(x)
          out.push(x)
          break
        end
      end
    end
  end
  out
end

require "spec"
describe "matchstring" do
  it "test_ex1" do
    matchstring(["cat", "cats", "dog", "dogcat", "dogcat", "rat", "ratcatdogcat"]).should eq ["cat", "dog", "dogcat", "rat"]
  end
  it "test_ex2" do
    matchstring(["hello", "hell", "world", "wor", "ellow", "elloworld"]).should eq ["hell", "world", "wor", "ellow"]
  end
  it "test_ex3" do
    matchstring(["a", "aa", "aaa", "aaaa"]).should eq ["a", "aa", "aaa"]
  end
  it "test_ex4" do
    matchstring(["flower", "flow", "flight", "fl", "fli", "ig", "ght"]).should eq ["flow", "fl", "fli", "ig", "ght"]
  end
  it "test_ex5" do
    matchstring(["car", "carpet", "carpenter", "pet", "enter", "pen", "pent"]).should eq ["car", "pet", "enter", "pen", "pent"]
  end
end
