#! /usr/bin/crystal

def largestnumber(a)
  ax = a.map{|x| x.to_s}
  ax.sort! do |i, j|
    ij = i + j
    ji = j + i
    ij.to_i <=> ji.to_i
  end
  ax.reverse!
  ax.join("").to_i
end

require "spec"
describe "largestnumber" do
  it "test_ex1" do
    largestnumber([20, 3]).should eq 320
  end
  it "test_ex2" do
    largestnumber([3, 30, 34, 5, 9]).should eq 9534330
  end
end
