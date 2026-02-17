#! /usr/bin/crystal

def zeckendorfrepresentation(a)
  fib = [0, 1]
  while fib[-1] <= a
    fib.push(fib[-1] + fib[-2])
  end
  fib.pop
  res = Array(Int32).new
  aw = a
  while aw > 0
    res.push(fib[-1])
    aw -= fib[-1]
    fib.pop
    fib.pop
    while fib[-1] > aw
      fib.pop
    end
  end
  res
end

require "spec"
describe "zeckendorfrepresentation" do
  it "test_ex1" do
    zeckendorfrepresentation(4).should eq [3, 1]
  end
  it "test_ex2" do
    zeckendorfrepresentation(12).should eq [8, 3, 1]
  end
  it "test_ex3" do
    zeckendorfrepresentation(20).should eq [13, 5, 2]
  end
  it "test_ex4" do
    zeckendorfrepresentation(96).should eq [89, 5, 2]
  end
  it "test_ex5" do
    zeckendorfrepresentation(100).should eq [89, 8, 3]
  end
end
