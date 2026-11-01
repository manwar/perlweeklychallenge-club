#! /usr/bin/crystal

def reflect(a)
  p = Array(Int32).new
  am = a
  while true
    p.push(am % 2)
    am >>= 1
    if am == 0
      break
    end
  end
  ar = 0
  s = p.size
  p.each do |n|
    s -= 1
    ar += n << s
  end
  ar
end

def binaryreflection(ax)
  k = ax.map{|x| reflect(x)}
  i = 0.upto(ax.size - 1).to_a
  i.sort! do |a, b|
    if k[a] == k[b]
      ax[a] <=> ax[b]
    else
      k[a] <=> k[b]
    end
  end
  i.map{|x| ax[x]}
end

require "spec"
describe "binaryreflection" do
  it "test_ex1" do
    binaryreflection([3, 6, 12]).should eq [3, 6, 12]
  end
  it "test_ex2" do
    binaryreflection([1, 2, 4, 8]).should eq [1, 2, 4, 8]
  end
  it "test_ex3" do
    binaryreflection([7, 8, 9, 10]).should eq [8, 10, 7, 9]
  end
  it "test_ex4" do
    binaryreflection([5, 9, 15, 17]).should eq [5, 9, 15, 17]
  end
  it "test_ex5" do
    binaryreflection([11, 13, 14, 19]).should eq [14, 13, 11, 19]
  end
end
