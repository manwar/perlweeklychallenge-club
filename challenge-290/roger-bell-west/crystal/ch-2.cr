#! /usr/bin/crystal

def luhnalgorithm(a)
  digits = a.chars.select{|x| x >= '0' && x <= '9'}.map{|x| x.to_i}
  payload = digits.pop
  digits = digits.reverse
  0.step(to: digits.size - 1, by: 2) do |i|
    digits[i] *= 2
    if digits[i] > 9
      digits[i] -= 9
    end
  end
  10 - (digits.sum() % 10) == payload
end

require "spec"
describe "luhnalgorithm" do
  it "test_ex1" do
    luhnalgorithm("17893729974").should eq true
  end
  it "test_ex2" do
    luhnalgorithm("4137 8947 1175 5904").should eq true
  end
  it "test_ex3" do
    luhnalgorithm("4137 8974 1175 5904").should eq false
  end
end
