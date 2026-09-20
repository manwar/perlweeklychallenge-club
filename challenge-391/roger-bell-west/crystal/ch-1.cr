#! /usr/bin/crystal
def arraymedian(a, b)
  nn = a
  b.each do |n|
    nn.push(n)
  end
  nn = nn.sort()
  i = nn.size // 2
  if nn.size % 2 == 0
    (nn[i - 1] + nn[i]).to_f / 2.0
  else
    nn[i].to_f
  end
end

require "spec"
describe "arraymedian" do
  it "test_ex1" do
    arraymedian([2], [4]).should eq 3
  end
  it "test_ex2" do
    arraymedian([1, 2, 3], [7, 8, 9, 10]).should eq 7
  end
  it "test_ex3" do
    arraymedian([] of Int32, [10, 20, 30, 40]).should eq 25
  end
  it "test_ex4" do
    arraymedian([100], [1, 2, 3, 4, 5, 6, 7]).should eq 4.5
  end
  it "test_ex5" do
    arraymedian([1, 2, 2], [2, 2, 3]).should eq 2
  end
end
