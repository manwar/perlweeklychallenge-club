#! /usr/bin/crystal

def buddystrings(a, b)
  ac = a.chars
  bc = b.chars
  0.upto(ac.size - 1) do |i|
    (i + 1).upto(ac.size - 1) do |j|
      acx = ac.clone
      acx[i] = ac[j]
      acx[j] = ac[i]
      if acx == bc
        return true
      end
    end
  end
  false
end

require "spec"
describe "buddystrings" do
  it "test_ex1" do
    buddystrings("fuck", "fcuk").should eq true
  end
  it "test_ex2" do
    buddystrings("love", "love").should eq false
  end
  it "test_ex3" do
    buddystrings("fodo", "food").should eq true
  end
  it "test_ex4" do
    buddystrings("feed", "feed").should eq true
  end
end
