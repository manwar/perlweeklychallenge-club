#! /usr/bin/crystal

def taxamount(income, brackets)
  tax = 0
  lastbracket = 0
  brackets.each do |bracket|
    if income > lastbracket
      tax += ([income, bracket[0]].min - lastbracket) * bracket[1]
    else
      break
    end
    lastbracket = bracket[0]
  end
  tax / 100.0
end

require "spec"
describe "taxamount" do
  it "test_ex1" do
    taxamount(10, [[3, 50], [7, 10], [12, 25]]).should eq 2.65
  end
  it "test_ex2" do
    taxamount(2, [[1, 0], [4, 25], [5, 50]]).should eq 0.25
  end
  it "test_ex3" do
    taxamount(0, [[2, 50]]).should eq 0
  end
end
