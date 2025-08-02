#! /usr/bin/crystal

def stepbystep(a)
  mv = 0
  tot = 0
  a.each do |s|
    tot += s
    if mv > tot
      mv = tot
    end
  end
  1 - mv
end

require "spec"
describe "stepbystep" do
  it "test_ex1" do
    stepbystep([-3, 2, -3, 4, 2]).should eq 5
  end
  it "test_ex2" do
    stepbystep([1, 2]).should eq 1
  end
  it "test_ex3" do
    stepbystep([1, -2, -3]).should eq 5
  end
end
