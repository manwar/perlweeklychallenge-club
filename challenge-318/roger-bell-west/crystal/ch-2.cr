#! /usr/bin/crystal

def reverseequals(a, b)
  if a == b
    return true
  end
  0.upto(a.size - 2) do |i|
    (i + 1).upto(a.size - 1) do |j|
      c = a.clone
      i.upto(j) do |x|
        c[x] = a[j - (x - i)]
      end
      if c == b
        return true
      end
    end
  end
  false
end

require "spec"
describe "reverseequals" do
  it "test_ex1" do
    reverseequals([3, 2, 1, 4], [1, 2, 3, 4]).should eq true
  end
  it "test_ex2" do
    reverseequals([1, 3, 4], [4, 1, 3]).should eq false
  end
  it "test_ex3" do
    reverseequals([2], [2]).should eq true
  end
end
