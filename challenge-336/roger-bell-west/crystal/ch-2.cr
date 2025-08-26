#! /usr/bin/crystal

def finalscore(a)
  p = Array(Int32).new
  a.each do |n|
    if n == "C"
      p.pop
    elsif n == "D"
      p.push(2 * p[-1])
    elsif n == "+"
      p.push(p[-2] + p[-1])
    else
      p.push(n.to_i)
    end
  end
  p.sum
end

require "spec"
describe "finalscore" do
  it "test_ex1" do
    finalscore(["5", "2", "C", "D", "+"]).should eq 30
  end
  it "test_ex2" do
    finalscore(["5", "-2", "4", "C", "D", "9", "+", "+"]).should eq 27
  end
  it "test_ex3" do
    finalscore(["7", "D", "D", "C", "+", "3"]).should eq 45
  end
  it "test_ex4" do
    finalscore(["-5", "-10", "+", "D", "C", "+"]).should eq -55
  end
  it "test_ex5" do
    finalscore(["3", "6", "+", "D", "C", "8", "+", "D", "-2", "C", "+"]).should eq 128
  end
end
