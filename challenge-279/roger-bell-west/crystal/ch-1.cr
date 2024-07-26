#! /usr/bin/crystal
require "spec"
describe "sortletters" do
  it "test_ex1" do
    sortletters(['R', 'E', 'P', 'L'], [3, 2, 1, 4]).should eq "PERL"
  end
  it "test_ex2" do
    sortletters(['A', 'U', 'R', 'K'], [2, 4, 1, 3]).should eq "RAKU"
  end
  it "test_ex3" do
    sortletters(['O', 'H', 'Y', 'N', 'P', 'T'], [5, 4, 2, 6, 1, 3]).should eq "PYTHON"
  end
end

def sortletters(a, n)
  out = a.clone
  a.each_with_index do |l, i|
    out[n[i] - 1] = l
  end
  out.join("")
end
