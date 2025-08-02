#! /usr/bin/crystal
require "spec"
describe "reverseword" do
  it "test_ex1" do
    reverseword("challenge", "e").should eq "acehllnge"
  end
  it "test_ex2" do
    reverseword("programming", "a").should eq "agoprrmming"
  end
  it "test_ex3" do
    reverseword("champion", "b").should eq "champion"
  end
end

def reverseword(a, c)
  mm = a.index(c)
  if mm.nil?
    return a
  end
  b = a[0, mm + 1].split("")
  b.sort!()
  b.concat(a[mm + 1, a.size - mm].split("") )
  b.join("")
end
