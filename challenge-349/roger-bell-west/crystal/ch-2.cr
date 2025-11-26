#! /usr/bin/crystal

def counterify(a)
  cc = Hash(Char, Int32).new(default_value: 0)
  a.each do |x|
    cc[x] += 1
  end
  return cc
end

def meetingpoint(a)
  c = counterify(a.chars)
  c['U'] == c['D'] && c['L'] == c['R']
end

require "spec"
describe "meetingpoint" do
  it "test_ex1" do
    meetingpoint("ULD").should eq false
  end
  it "test_ex2" do
    meetingpoint("ULDR").should eq true
  end
  it "test_ex3" do
    meetingpoint("UUURRRDDD").should eq false
  end
  it "test_ex4" do
    meetingpoint("UURRRDDLLL").should eq true
  end
  it "test_ex5" do
    meetingpoint("RRUULLDDRRUU").should eq false
  end
end
