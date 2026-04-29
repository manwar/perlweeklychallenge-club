#! /usr/bin/crystal

def subsetequilibrium(a)
  out = Array(Array(Int32)).new
  b = a.each_with_index.map{|x, i| x - i - 1}.to_a
  ix = (0 .. b.size - 1).to_a
  1.upto(b.size - 1) do |n|
    ix.combinations(n).each do |iy|
      bp = iy.map{|i| b[i]}.sum
      if bp == 0
        ap = iy.map{|i| a[i]}
        out.push(ap)
      end
    end
  end
  out.sort()
end

require "spec"
describe "subsetequilibrium" do
  it "test_ex1" do
    subsetequilibrium([2, 1, 4, 3]).should eq [[1, 4], [2, 1], [2, 3], [4, 3]]
  end
  it "test_ex2" do
    subsetequilibrium([3, 0, 3, 0]).should eq [[3], [3, 0], [3, 0, 3]]
  end
  it "test_ex3" do
    subsetequilibrium([5, 1, 1, 1]).should eq [[5, 1, 1]]
  end
  it "test_ex4" do
    subsetequilibrium([3, -1, 4, 2]).should eq [[3, -1, 4], [3, 2]]
  end
  it "test_ex5" do
    subsetequilibrium([10, 20, 30, 40]).should eq Array(Array(Int32)).new
  end
end
