#! /usr/bin/crystal

def backspacecompare(a, b)
  sa = Array(String).new
  [a, b].each do |i|
    oa = Array(Char).new
    i.chars.each do |c|
      if c == '#'
        oa.pop
      else
        oa.push(c)
      end
    end
    sa.push(oa.join(""))
  end
  sa[0] == sa[1]
end

require "spec"
describe "backspacecompare" do
  it "test_ex1" do
    backspacecompare("ab#c", "ad#c").should eq true
  end
  it "test_ex2" do
    backspacecompare("ab##", "a#b#").should eq true
  end
  it "test_ex3" do
    backspacecompare("a#b", "c").should eq false
  end
end
