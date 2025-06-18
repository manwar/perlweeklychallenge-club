#! /usr/bin/crystal

def dayoftheyear(a)
  d1 = Time.parse(a, "%Y-%m-%d", Time::Location::UTC)
  d0 = Time.utc(d1.year, 1, 1, 0, 0, 0)
  (d1 - d0).days + 1             
end

require "spec"
describe "dayoftheyear" do
  it "test_ex1" do
    dayoftheyear("2025-02-02").should eq 33
  end
  it "test_ex2" do
    dayoftheyear("2025-04-10").should eq 100
  end
  it "test_ex3" do
    dayoftheyear("2025-09-07").should eq 250
  end
end
