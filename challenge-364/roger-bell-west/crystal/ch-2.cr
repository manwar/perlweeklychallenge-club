#! /usr/bin/crystal

def goalparser(a)
  out = ""
  s = 0
  while s < a.size
    if a[s..-1].starts_with?("G")
      s += 1
      out += "G"
    elsif a[s..-1].starts_with?("()")
      s += 2
      out += "o"
    elsif a[s..-1].starts_with?("(al)")
      s += 4
      out += "al"
    else
      return ""
    end
  end
  out
end

require "spec"
describe "goalparser" do
  it "test_ex1" do
    goalparser("G()(al)").should eq "Goal"
  end
  it "test_ex2" do
    goalparser("G()()()()(al)").should eq "Gooooal"
  end
  it "test_ex3" do
    goalparser("(al)G(al)()()").should eq "alGaloo"
  end
  it "test_ex4" do
    goalparser("()G()G").should eq "oGoG"
  end
  it "test_ex5" do
    goalparser("(al)(al)G()()").should eq "alalGoo"
  end
end
