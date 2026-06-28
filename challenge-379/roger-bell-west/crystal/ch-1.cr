#! /usr/bin/crystal

def reversestring(a)
  if a == ""
    return a
  end
  b = ""
  l = a.size - 1
  aa = a.chars
  0.upto(l) do |i|
    b += aa[l - i]
  end
  b
end

require "spec"
describe "reversestring" do
  it "test_ex1" do
    reversestring("").should eq ""
  end
  it "test_ex2" do
    reversestring("reverse the given string").should eq "gnirts nevig eht esrever"
  end
end
