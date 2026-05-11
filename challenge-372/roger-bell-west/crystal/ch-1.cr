#! /usr/bin/crystal

def rearrangespaces(a)
  words = Array(String).new
  spaces = 0
  ww = ""
  a.chars.each do |c|
    if c == ' '
      spaces += 1
      if ww != ""
        words.push(ww)
        ww = ""
      end
    else
      ww += c
    end
  end
  if ww != ""
    words.push(ww)
  end
  spdiv = 0
  remainder = spaces
  divs = words.size - 1
  if divs > 0
    spdiv, remainder = spaces.divmod(divs)
  end
  out = words.join(" " * spdiv)
  if remainder > 0
    out += " " * remainder
  end
  out
end

require "spec"
describe "rearrangespaces" do
  it "test_ex1" do
    rearrangespaces("  challenge  ").should eq "challenge    "
  end
  it "test_ex2" do
    rearrangespaces("coding  is  fun").should eq "coding  is  fun"
  end
  it "test_ex3" do
    rearrangespaces("a b c  d").should eq "a b c d "
  end
  it "test_ex4" do
    rearrangespaces("  team      pwc  ").should eq "team          pwc"
  end
  it "test_ex5" do
    rearrangespaces("   the  weekly  challenge  ").should eq "the    weekly    challenge "
  end
end
