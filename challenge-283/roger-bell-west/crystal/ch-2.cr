#! /usr/bin/crystal

def digitcountvalue(a)
  c = Hash(Int32, Int32).new(default_value: 0)
  a.each do |n|
    c[n] += 1
  end
  0.upto(a.size - 1) do |ix|
    if a[ix] != c[ix]
      return false
    end
  end
  true
end

require "spec"
describe "digitcountvalue" do
  it "test_ex1" do
    digitcountvalue([1, 2, 1, 0]).should eq true
  end
  it "test_ex2" do
    digitcountvalue([0, 3, 0]).should eq false
  end
end
