#! /usr/bin/crystal

def groupdivision(a, sz, pad)
  a.chars.in_groups_of(sz, pad).map{|x| x.join("")}
end

require "spec"
describe "groupdivision" do
  it "test_ex1" do
    groupdivision("RakuPerl", 4, "*").should eq ["Raku", "Perl"]
  end
  it "test_ex2" do
    groupdivision("Python", 5, "0").should eq ["Pytho", "n0000"]
  end
  it "test_ex3" do
    groupdivision("12345", 3, "x").should eq ["123", "45x"]
  end
  it "test_ex4" do
    groupdivision("HelloWorld", 3, "_").should eq ["Hel", "loW", "orl", "d__"]
  end
  it "test_ex5" do
    groupdivision("AI", 5, "!").should eq ["AI!!!"]
  end
end
