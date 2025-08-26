#! /usr/bin/crystal

def counterify(a)
  cc = Hash(Int32, Int32).new(default_value: 0)
  a.each do |x|
    cc[x] += 1
  end
  return cc
end

def equalgroup(a)
  s = counterify(a)
  v = s.values.to_set.to_a.sort
  l = v[0]
  if l < 2
    return false
  end
  2.upto(l) do |t|
    if v.all? { |c| c % t == 0 }
      return true
    end
  end
  false
end

require "spec"

describe "equalgroup" do
  it "test_ex1" do
    equalgroup([1, 1, 2, 2, 2, 2]).should eq true
  end
  it "test_ex2" do
    equalgroup([1, 1, 1, 2, 2, 2, 3, 3]).should eq false
  end
  it "test_ex3" do
    equalgroup([5, 5, 5, 5, 5, 5, 7, 7, 7, 7, 7, 7]).should eq true
  end
  it "test_ex4" do
    equalgroup([1, 2, 3, 4]).should eq false
  end
  it "test_ex5" do
    equalgroup([8, 8, 9, 9, 10, 10, 11, 11]).should eq true
  end
end
