#! /usr/bin/crystal

def goatlatin(a)
  out = [] of String
  a.split(" ").each_with_index do |word, ix|
    c = word.split("")
    if c[0] !~ /[aeiou]/i
      co = c.shift;
      c.push(co)
    end
    nw = c.join("")
    nw += "ma"
    0.upto(ix) do
      nw += "a"
    end
    out.push(nw)
  end
  out.join(" ")
end

require "spec"
describe "goatlatin" do
  it "test_ex1" do
    goatlatin("I love Perl").should eq "Imaa ovelmaaa erlPmaaaa"
  end
  it "test_ex2" do
    goatlatin("Perl and Raku are friends").should eq "erlPmaa andmaaa akuRmaaaa aremaaaaa riendsfmaaaaaa"
  end
  it "test_ex3" do
    goatlatin("The Weekly Challenge").should eq "heTmaa eeklyWmaaa hallengeCmaaaa"
  end
end
