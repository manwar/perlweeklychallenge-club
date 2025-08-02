#! /usr/bin/crystal

def luckyinteger(a)
  c = Hash(Int32, Int32).new(default_value: 0)
  a.each do |n|
    c[n] += 1
  end
  c1 = c.values.sort.reverse
  c2 = c.keys.sort.reverse
  c1.each do |v1|
    c2.each do |v2|
      if c[v2] == v1 && v1 == v2
        return v2
      end
    end
  end
  -1
end

require "spec"
describe "luckyinteger" do
  it "test_ex1" do
    luckyinteger([2, 2, 3, 4]).should eq 2
  end
  it "test_ex2" do
    luckyinteger([1, 2, 2, 3, 3, 3]).should eq 3
  end
  it "test_ex3" do
    luckyinteger([1, 1, 1, 3]).should eq -1
  end
end
