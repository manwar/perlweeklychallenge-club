#! /usr/bin/crystal

def arraysintersection(a)
  s = a[0].to_set
  a.skip(1).each do |b|
    s = s & b.to_set
  end
  s.to_a.sort
end

require "spec"
describe "arraysintersection" do
  it "test_ex1" do
    arraysintersection([[1, 2, 3, 4], [4, 5, 6, 1], [4, 2, 1, 3]]).should eq [1, 4]
  end
  it "test_ex2" do
    arraysintersection([[1, 0, 2, 3], [2, 4, 5]]).should eq [2]
  end
  it "test_ex3" do
    arraysintersection([[1, 2, 3], [4, 5], [6]]).should eq [] of Int32
  end
end
