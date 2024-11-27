#! /usr/bin/crystal

def nextpermutation(a)
  b = a.sort
  flag = false
  out = [] of Int32
  b.permutations.each do |px|
    if out.size == 0
      out = px
    end
    if flag
      out= px
      break
    end
    if px == a
      flag = true
    end
  end
  out
end

require "spec"
describe "nextpermutation" do
  it "test_ex1" do
    nextpermutation([1, 2, 3]).should eq [1, 3, 2]
  end
  it "test_ex2" do
    nextpermutation([2, 1, 3]).should eq [2, 3, 1]
  end
  it "test_ex3" do
    nextpermutation([3, 1, 2]).should eq [3, 2, 1]
  end
end
