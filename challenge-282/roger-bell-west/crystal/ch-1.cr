#! /usr/bin/crystal
require "spec"
describe "goodinteger" do
  it "test_ex1" do
    goodinteger(12344456).should eq 444
  end
  it "test_ex2" do
    goodinteger(1233334).should eq -1
  end
  it "test_ex3" do
    goodinteger(10020003).should eq 0
  end
end

def goodinteger(a)
  winsize = 3
  d = a.to_s.chars
  d.each_cons(winsize).each_with_index do |cc, offset|
    if cc[0] == cc[1] && cc[1] == cc[2]
      if (offset == 0 || d[offset - 1] != cc[0]) && (offset == d.size - winsize || d[offset + winsize] != cc[2])
        return cc.join("").to_i
      end
    end
  end
  -1
end
