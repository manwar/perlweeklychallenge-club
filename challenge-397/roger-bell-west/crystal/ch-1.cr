#! /usr/bin/crystal

def absentsmallestpositive(a)
  tot = a.sum
  ex = a.to_set
  mul = a.size
  n = 1
  while true
    if n * mul > tot && !ex.includes?(n)
      return n
    end
    n += 1
  end
end

require "spec"
describe "absentsmallestpositive" do
  it "test_ex1" do
    absentsmallestpositive([1, 2, 4, 5, 6]).should eq 7
  end
  it "test_ex2" do
    absentsmallestpositive([-5, -2, -1, 3]).should eq 1
  end
  it "test_ex3" do
    absentsmallestpositive([1, 2, 3]).should eq 4
  end
  it "test_ex4" do
    absentsmallestpositive([2, 3, 7, 8]).should eq 6
  end
  it "test_ex5" do
    absentsmallestpositive([1, 1, 1, 10]).should eq 4
  end
end
