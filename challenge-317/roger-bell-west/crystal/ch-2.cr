#! /usr/bin/crystal

def friendlystrings(a, b)
  aa = a.chars()
  bb = b.chars()
  0.upto(aa.size - 2) do |i|
    (i + 1).upto(aa.size - 1) do |j|
      cc = aa.clone
      cc[i] = aa[j]
      cc[j] = aa[i]
      if cc == bb
        return true
      end
    end
  end
  false
end

require "spec"
describe "friendlystrings" do
  it "test_ex1" do
    friendlystrings("desc", "dsec").should eq true
  end
  it "test_ex2" do
    friendlystrings("fuck", "fcuk").should eq true
  end
  it "test_ex3" do
    friendlystrings("poo", "eop").should eq false
  end
  it "test_ex4" do
    friendlystrings("stripe", "sprite").should eq true
  end
end
