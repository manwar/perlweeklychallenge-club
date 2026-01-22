#! /usr/bin/crystal

def uniquefractiongenerator(a)
  den = 1
  2.upto(a) do |dn|
    den *= dn
  end
  f = Set(Int32).new
  1.upto(a) do |d|
    nd = den // d
    1.upto(a) do |n|
      f.add(n * nd)
    end
  end
  out = Array(String).new
  f.to_a.sort.each do |n|
    g = n.gcd(den)
    nn = n // g
    nd = den // g
    out.push(sprintf("%s/%s", nn, nd))
  end
  out
end

require "spec"
describe "uniquefractiongenerator" do
  it "test_ex1" do
    uniquefractiongenerator(3).should eq ["1/3", "1/2", "2/3", "1/1", "3/2", "2/1", "3/1"]
  end
  it "test_ex2" do
    uniquefractiongenerator(4).should eq ["1/4", "1/3", "1/2", "2/3", "3/4", "1/1", "4/3", "3/2", "2/1", "3/1", "4/1"]
  end
  it "test_ex3" do
    uniquefractiongenerator(1).should eq ["1/1"]
  end
  it "test_ex4" do
    uniquefractiongenerator(6).should eq ["1/6", "1/5", "1/4", "1/3", "2/5", "1/2", "3/5", "2/3", "3/4", "4/5", "5/6", "1/1", "6/5", "5/4", "4/3", "3/2", "5/3", "2/1", "5/2", "3/1", "4/1", "5/1", "6/1"]
  end
  it "test_ex5" do
    uniquefractiongenerator(5).should eq ["1/5", "1/4", "1/3", "2/5", "1/2", "3/5", "2/3", "3/4", "4/5", "1/1", "5/4", "4/3", "3/2", "5/3", "2/1", "5/2", "3/1", "4/1", "5/1"]
  end
end
