#! /usr/bin/crystal

def arrangebox(a0)
  a = a0.sort
  stack = Array(Tuple(Int32, Int32)).new
  mx = 1
  0.upto(a.size - 1) do |i|
    stack.push({i, 1})
  end
  while stack.size > 0
    ix, pm = stack.pop
    if pm > mx
            mx = pm
    end
    (ix + 1).upto(a.size - 1) do |j|
      if a[ix][0] < a[j][0] && a[ix][1] < a[j][1]
        stack.push({j, pm + 1})
      end
    end
  end
  mx
end

require "spec"
describe "arrangebox" do
  it "test_ex1" do
    arrangebox([[1, 3], [3, 5], [6, 8], [2, 4]]).should eq 4
  end
  it "test_ex2" do
    arrangebox([[4, 5], [4, 6], [6, 7], [2, 3], [4, 3]]).should eq 3
  end
  it "test_ex3" do
    arrangebox([[5, 5], [5, 5], [5, 5]]).should eq 1
  end
  it "test_ex4" do
    arrangebox([[2, 100], [3, 200], [4, 300], [5, 50], [5, 400]]).should eq 4
  end
  it "test_ex5" do
    arrangebox([[10, 20], [15, 10], [20, 30], [12, 18], [16, 25]]).should eq 3
  end
end
