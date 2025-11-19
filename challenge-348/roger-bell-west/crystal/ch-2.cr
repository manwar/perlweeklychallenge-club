#! /usr/bin/crystal

def hm2m(a)
  p = a.split(":")
  return p[0].to_i * 60 + p[1].to_i
end

def converttime(ssrc, ttgt)
  src = hm2m(ssrc)
  tgt = hm2m(ttgt)
  if tgt < src
    tgt += 24 * 60
  end
  delta = tgt - src
  oc = 0
  [60, 15, 5, 1].each do |op|
    q, delta = delta.divmod(op)
    oc += q
  end
  oc
end

require "spec"
describe "converttime" do
  it "test_ex1" do
    converttime("02:30", "02:45").should eq 1
  end
  it "test_ex2" do
    converttime("11:55", "12:15").should eq 2
  end
  it "test_ex3" do
    converttime("09:00", "13:00").should eq 4
  end
  it "test_ex4" do
    converttime("23:45", "00:30").should eq 3
  end
  it "test_ex5" do
    converttime("14:20", "15:25").should eq 2
  end
end
