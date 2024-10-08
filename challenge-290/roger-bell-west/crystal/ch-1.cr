#! /usr/bin/crystal

def doubleexist(a)
  a.combinations(2).each do |i|
    if i[0] == 2 * i[1] || i[1] == 2 * i[0]
      return true
    end
  end
  false
end

require "spec"
describe "doubleexist" do
  it "test_ex1" do
    doubleexist([6, 2, 3, 3]).should eq true
  end
  it "test_ex2" do
    doubleexist([3, 1, 4, 13]).should eq false
  end
  it "test_ex3" do
    doubleexist([2, 1, 4, 2]).should eq true
  end
end
