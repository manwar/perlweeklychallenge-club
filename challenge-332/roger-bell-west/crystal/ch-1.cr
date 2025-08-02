#! /usr/bin/crystal

def binarydate(a)
  a.split("-").map{|n| n.to_i.to_s(2)}.join("-")
end

require "spec"
describe "binarydate" do
  it "test_ex1" do
    binarydate("2025-07-26").should eq "11111101001-111-11010"
  end
  it "test_ex2" do
    binarydate("2000-02-02").should eq "11111010000-10-10"
  end
  it "test_ex3" do
    binarydate("2024-12-31").should eq "11111101000-1100-11111"
  end
end
