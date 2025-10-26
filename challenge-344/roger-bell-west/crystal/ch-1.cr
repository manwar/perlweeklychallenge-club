#! /usr/bin/crystal

def u2a(a)
  p = a
  if p > 0
    out = Array(Int32).new
    while p > 0
      p, x = p.divmod(10)
      out.unshift(x)
    end
    out
  else
    [0]
  end
end

def a2u(a)
  acc = 0
  a.each do |d|
    acc *= 10
    acc += d
  end
  acc
end

def arrayformcompute(a, b)
  u2a(a2u(a) + b)
end

require "spec"
describe "arrayformcompute" do
  it "test_ex1" do
    arrayformcompute([1, 2, 3, 4], 12).should eq [1, 2, 4, 6]
  end
  it "test_ex2" do
    arrayformcompute([2, 7, 4], 181).should eq [4, 5, 5]
  end
  it "test_ex3" do
    arrayformcompute([9, 9, 9], 1).should eq [1, 0, 0, 0]
  end
  it "test_ex4" do
    arrayformcompute([1, 0, 0, 0, 0], 9999).should eq [1, 9, 9, 9, 9]
  end
  it "test_ex5" do
    arrayformcompute([0], 1000).should eq [1, 0, 0, 0]
  end
end
