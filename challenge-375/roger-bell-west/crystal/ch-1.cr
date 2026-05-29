#! /usr/bin/crystal

def counterify(a)
  cc = Hash(String, Int32).new(default_value: 0)
  a.each do |x|
    cc[x] += 1
  end
  return cc
end


def singlecommonword(a, b)
  ac = counterify(a)
  bc = counterify(b)
  total = 0
  ac.each do |(w, ca)|
    if ca == 1 && bc.has_key?(w) && bc[w] == 1
      total += 1
    end
  end
  total
end

require "spec"
describe "singlecommonword" do
  it "test_ex1" do
    singlecommonword(["apple", "banana", "cherry"], ["banana", "cherry", "date"]).should eq 2
  end
  it "test_ex2" do
    singlecommonword(["a", "ab", "abc"], ["a", "a", "ab", "abc"]).should eq 2
  end
  it "test_ex3" do
    singlecommonword(["orange", "lemon"], ["grape", "melon"]).should eq 0
  end
  it "test_ex4" do
    singlecommonword(["test", "test", "demo"], ["test", "demo", "demo"]).should eq 0
  end
  it "test_ex5" do
    singlecommonword(["Hello", "world"], ["hello", "world"]).should eq 1
  end
end
