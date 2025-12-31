#! /usr/bin/crystal

def minabsdiff(a)
  b = a.sort
  out = Array(Array(Int32)).new
  mindiff = 1 + b[b.size - 1] - b[0]
  b.each_cons(2) do |c|
    d = c[1] - c[0]
    if d < mindiff
      out = Array(Array(Int32)).new
      mindiff = d
    end
    if d == mindiff
      out.push(c)
    end
  end
  out
end

require "spec"
describe "minabsdiff" do
  it "test_ex1" do
    minabsdiff([4, 2, 1, 3]).should eq [[1, 2], [2, 3], [3, 4]]
  end
  it "test_ex2" do
    minabsdiff([10, 100, 20, 30]).should eq [[10, 20], [20, 30]]
  end
  it "test_ex3" do
    minabsdiff([-5, -2, 0, 3]).should eq [[-2, 0]]
  end
  it "test_ex4" do
    minabsdiff([8, 1, 15, 3]).should eq [[1, 3]]
  end
  it "test_ex5" do
    minabsdiff([12, 5, 9, 1, 15]).should eq [[9, 12], [12, 15]]
  end
end
