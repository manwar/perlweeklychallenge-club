#! /usr/bin/crystal

def thirdmaximum(a)
  p = Set.new(a).to_a.sort.reverse
  if p.size > 2
    p[2]
  else
    p[0]
  end
end

require "spec"
describe "thirdmaximum" do
  it "test_ex1" do
    thirdmaximum([5, 6, 4, 1]).should eq 4
  end
  it "test_ex2" do
    thirdmaximum([4, 5]).should eq 5
  end
  it "test_ex3" do
    thirdmaximum([1, 2, 2, 3]).should eq 1
  end
end
