#! /usr/bin/crystal

def defrangip(a)
  return a.gsub(".", "[.]")
end

require "spec"
describe "defrangip" do
  it "test_ex1" do
    defrangip("1.1.1.1").should eq "1[.]1[.]1[.]1"
  end
  it "test_ex2" do
    defrangip("255.101.1.0").should eq "255[.]101[.]1[.]0"
  end
end
