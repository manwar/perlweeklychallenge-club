#! /usr/bin/crystal

def consecutiveone(a)
  h = Hash(Int32, Int32).new
  h[0] = 0
  latch = 0
  latched = false
  a.each_with_index do |n, i|
    if n == 1 && !latched
      latched = true
      latch = i
    end
    if n == 0 && latched
      latched = false
      h[latch] = i - latch
    end
  end
  if latched
    h[latch] = a.size - latch
  end
  h.values.max
end

require "spec"
describe "consecutiveone" do
  it "test_ex1" do
    consecutiveone([0, 1, 1, 0, 1, 1, 1]).should eq 3
  end
  it "test_ex2" do
    consecutiveone([0, 0, 0, 0]).should eq 0
  end
  it "test_ex3" do
    consecutiveone([1, 0, 1, 0, 1, 1]).should eq 2
  end
end
