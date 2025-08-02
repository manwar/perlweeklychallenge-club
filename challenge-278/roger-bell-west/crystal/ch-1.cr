#! /usr/bin/crystal
require "spec"
describe "sortstring" do
  it "test_ex1" do
    sortstring("and2 Raku3 cousins5 Perl1 are4").should eq "Perl and Raku are cousins"
  end
  it "test_ex2" do
    sortstring("guest6 Python1 most4 the3 popular5 is2 language7").should eq "Python is the most popular guest language"
  end
  it "test_ex3" do
    sortstring("Challenge3 The1 Weekly2").should eq "The Weekly Challenge"
  end
end

def sortstring(a)
  words = a.split(" ")
  out = words.clone
  words.each do |w|
    if md = /^(.*?)([0-9]+)$/.match(w)
      ix = md[2].to_i - 1
      out[ix] = md[1]
    end
  end
  out.join(" ")
end
