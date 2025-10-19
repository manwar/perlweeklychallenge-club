#! /usr/bin/crystal

def zerofriend(a)
  b = a.map { |x| x.abs }.min
  if a.includes?(b)
    return b
  end
  -b
end

require "spec"
describe "zerofriend" do
  it "test_ex1" do
    zerofriend([4, 2, -1, 3, -2]).should eq -1
  end
  it "test_ex2" do
    zerofriend([-5, 5, -3, 3, -1, 1]).should eq 1
  end
  it "test_ex3" do
    zerofriend([7, -3, 0, 2, -8]).should eq 0
  end
  it "test_ex4" do
    zerofriend([-2, -5, -1, -8]).should eq -1
  end
  it "test_ex5" do
    zerofriend([-2, 2, -4, 4, -1, 1]).should eq 1
  end
end
