#! /usr/bin/crystal

def uniquenumber(a)
  c = Hash(Int32, Int32).new(default_value: 0)
  a.each do |n|
    c[n] += 1
  end
  c.select{|k, v| v == 1}.map{|k, v| k}[0]
end

require "spec"
describe "uniquenumber" do
  it "test_ex1" do
    uniquenumber([3, 3, 1]).should eq 1
  end
  it "test_ex2" do
    uniquenumber([3, 2, 4, 2, 4]).should eq 3
  end
  it "test_ex3" do
    uniquenumber([1]).should eq 1
  end
  it "test_ex4" do
    uniquenumber([4, 3, 1, 1, 1, 4]).should eq 3
  end
end
