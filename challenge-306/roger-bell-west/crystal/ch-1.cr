#! /usr/bin/crystal

def oddsum(a)
  out = a.sum
  l = 3
  while l <= a.size
    a.each_cons(l) do |s|
      out += s.sum
    end
    l += 2
  end
  out
end

require "spec"

describe "oddsum" do
  it "test_ex1" do
    oddsum([2, 5, 3, 6, 4]).should eq 77
  end
  it "test_ex2" do
    oddsum([1, 3]).should eq 4
  end
end
