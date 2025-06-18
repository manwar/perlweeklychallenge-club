#! /usr/bin/crystal

def decompressedlist(a)
  out = Array(Int32).new
  a.each_slice(2) do |n|
    out.concat(Array.new(n[0], n[1]))
  end
  out
end

require "spec"
describe "decompressedlist" do
  it "test_ex1" do
    decompressedlist([1, 3, 2, 4]).should eq [3, 4, 4]
  end
  it "test_ex2" do
    decompressedlist([1, 1, 2, 2]).should eq [1, 2, 2]
  end
  it "test_ex3" do
    decompressedlist([3, 1, 3, 2]).should eq [1, 1, 1, 2, 2, 2]
  end
end
