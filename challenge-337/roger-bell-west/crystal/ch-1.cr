#! /usr/bin/crystal

def smallerthancurrent(a)
  b = a.sort()
  m = Hash(Int32, Int32).new
  b.each_with_index do |v, i|
    if !m.has_key?(v)
      m[v] = i
    end
  end
  a.map{|x| m[x]}
end

require "spec"
describe "smallerthancurrent" do
  it "test_ex1" do
    smallerthancurrent([6, 5, 4, 8]).should eq [2, 1, 0, 3]
  end
  it "test_ex2" do
    smallerthancurrent([7, 7, 7, 7]).should eq [0, 0, 0, 0]
  end
  it "test_ex3" do
    smallerthancurrent([5, 4, 3, 2, 1]).should eq [4, 3, 2, 1, 0]
  end
  it "test_ex4" do
    smallerthancurrent([-1, 0, 3, -2, 1]).should eq [1, 2, 4, 0, 3]
  end
  it "test_ex5" do
    smallerthancurrent([0, 1, 1, 2, 0]).should eq [0, 2, 2, 4, 0]
  end
end
