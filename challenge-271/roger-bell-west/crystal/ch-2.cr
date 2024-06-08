#! /usr/bin/crystal

def sortbyonebits(a)
  c = Hash(Int32, Int32).new
  Set.new(a).each do |n|
    c[n] = n.popcount
  end
  a.sort do |aa, bb|
    if c[aa] == c[bb]
      aa <=> bb
    else
      c[aa] <=> c[bb]
    end
  end
end

require "spec"
describe "#tmpl_var name=function>" do
  it "test_ex1" do
    sortbyonebits([0, 1, 2, 3, 4, 5, 6, 7, 8]).should eq [0, 1, 2, 4, 8, 3, 5, 6, 7]
  end
  it "test_ex2" do
    sortbyonebits([1024, 512, 256, 128, 64]).should eq [64, 128, 256, 512, 1024]
  end
end
