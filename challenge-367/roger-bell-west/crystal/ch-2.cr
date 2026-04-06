#! /usr/bin/crystal

def parsetime(t)
  p = t.split(":")
  p[0].to_i * 60 + p[1].to_i
end

def conflictevents(a, b)
  r = Array(Array(Array(Int32))).new
  [a, b].each do |t|
    st = parsetime(t[0])
    en = parsetime(t[1])
    if st < en
      r.push([[st, en - 1]])
    else
      r.push([
               [st, 1440 - 1],
               [0, en - 1]
             ])
    end
  end
  r[0].each do |ra|
    r[1].each do |rb|
      if ra[0] <= rb[1] && rb[0] <= ra[1]
        return true
      end
    end
  end
  false
end

require "spec"
describe "conflictevents" do
  it "test_ex1" do
    conflictevents(["10:00", "12:00"], ["11:00", "13:00"]).should eq true
  end
  it "test_ex2" do
    conflictevents(["09:00", "10:30"], ["10:30", "12:00"]).should eq false
  end
  it "test_ex3" do
    conflictevents(["14:00", "15:30"], ["14:30", "16:00"]).should eq true
  end
  it "test_ex4" do
    conflictevents(["08:00", "09:00"], ["09:01", "10:00"]).should eq false
  end
  it "test_ex5" do
    conflictevents(["23:30", "00:30"], ["00:00", "01:00"]).should eq true
  end
end
