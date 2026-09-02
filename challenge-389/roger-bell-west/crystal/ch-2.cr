#! /usr/bin/crystal

def zigzagsubarray(a)
  mx = [1, a.size].min
  0.upto(a.size - 1) do |i|
    o = 0
    lastdir = 0
    i.upto(a.size - 1) do |j|
      thisdir = 0
      if j > i
        if a[j] > o
          thisdir = 1
          mx = [mx, 2].max
        elsif a[j] < o
          thisdir = -1
          mx = [mx, 2].max
        end
      end
      if (j > i && thisdir == 0) || (j > i + 1 && thisdir * lastdir != -1)
        break
      end
      o = a[j]
      lastdir = thisdir
      mx = [mx, j - i + 1].max
    end
  end
  mx
end

require "spec"
describe "zigzagsubarray" do
  it "test_ex1" do
    zigzagsubarray([9, 4, 2, 10, 7, 8, 8, 1, 9]).should eq 5
  end
  it "test_ex2" do
    zigzagsubarray([1, 7, 4, 9, 2, 5]).should eq 6
  end
  it "test_ex3" do
    zigzagsubarray([1, 2, 3, 4, 5]).should eq 2
  end
  it "test_ex4" do
    zigzagsubarray([4, 4, 4]).should eq 1
  end
  it "test_ex5" do
    zigzagsubarray([10, 20, 15, 12, 18]).should eq 3
  end
end
