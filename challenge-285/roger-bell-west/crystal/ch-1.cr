#! /usr/bin/crystal

def noconnection(a)
  os = Set.new(a.map {|x| x[0]})
  is = Set.new(a.map {|x| x[1]})
  (is - os).to_a[0]
end

require "spec"
describe "noconnection" do
  it "test_ex1" do
    noconnection([["B", "C"], ["D", "B"], ["C", "A"]]).should eq "A"
  end
  it "test_ex2" do
    noconnection([["A", "Z"]]).should eq "Z"
  end
end
