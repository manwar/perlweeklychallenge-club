#! /usr/bin/crystal

def prefixsuffix(a0)
  tot = 0
  a = a0.sort_by { |x| x.size }
  0.upto(a.size - 2) do |si|
    (si + 1).upto(a.size - 1) do |li|
      le = a[li].index(a[si])
      ri = a[li].rindex(a[si])
      if le == 0 && ri == a[li].size - a[si].size
        tot += 1
      end
    end
  end
  tot
end

require "spec"
describe "prefixsuffix" do
  it "test_ex1" do
    prefixsuffix(["a", "aba", "ababa", "aa"]).should eq 4
  end
  it "test_ex2" do
    prefixsuffix(["pa", "papa", "ma", "mama"]).should eq 2
  end
  it "test_ex3" do
    prefixsuffix(["abao", "abab"]).should eq 0
  end
  it "test_ex4" do
    prefixsuffix(["abab", "abab"]).should eq 1
  end
  it "test_ex5" do
    prefixsuffix(["ab", "abab", "ababab"]).should eq 3
  end
end
