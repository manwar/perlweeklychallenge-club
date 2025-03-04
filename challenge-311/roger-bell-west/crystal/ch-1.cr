#! /usr/bin/crystal

def upperlower(a)
  out = ""
  a.chars.each do |c|
    out += (c.ord ^ 32).chr
  end
  out
end

require "spec"
describe "upperlower" do
  it "test_ex1" do
    upperlower("pERL").should eq "Perl"
  end
  it "test_ex2" do
    upperlower("rakU").should eq "RAKu"
  end
  it "test_ex3" do
    upperlower("PyThOn").should eq "pYtHoN"
  end
end
