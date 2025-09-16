#! /usr/bin/crystal

def maxdiff(a)
  md = 0
  0.upto(a.size - 2) do |w|
    (w + 1).upto(a.size - 1) do |x|
      (w + 1).upto(a.size - 2) do |y|
        if y != x
          (y + 1).upto(a.size - 1) do |z|
            if z != x
              v = (a[w] * a[x] - a[y] * a[z]).abs
              md = [md, v].max
            end
          end
        end
      end
    end
  end
  md
end

require "spec"
describe "maxdiff" do
  it "test_ex1" do
    maxdiff([5, 9, 3, 4, 6]).should eq 42
  end
  it "test_ex2" do
    maxdiff([1, -2, 3, -4]).should eq 10
  end
  it "test_ex3" do
    maxdiff([-3, -1, -2, -4]).should eq 10
  end
  it "test_ex4" do
    maxdiff([10, 2, 0, 5, 1]).should eq 50
  end
  it "test_ex5" do
    maxdiff([7, 8, 9, 10, 10]).should eq 44
  end
end
