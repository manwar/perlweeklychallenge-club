#! /usr/bin/crystal

def decodexor(a, init)
  ot = [ init ]
  a.each do |v|
    ot.push(ot[-1] ^ v)
  end
  ot
end

require "spec"
describe "decodexor" do
  it "test_ex1" do
    decodexor([1, 2, 3], 1).should eq [1, 0, 2, 1]
  end
  it "test_ex2" do
    decodexor([6, 2, 7, 3], 4).should eq [4, 2, 0, 7, 4]
  end
end
