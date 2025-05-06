#! /usr/bin/crystal

def maximumcount(a)
  pos = 0
  neg = 0
  a.each do |n|
    if n > 0
      pos += 1
    elsif n < 0
      neg += 1
    end
  end
  [pos, neg].max
end

require "spec"
describe "maximumcount" do
  it "test_ex1" do
    maximumcount([-3, -2, -1, 1, 2, 3]).should eq 3
  end
  it "test_ex2" do
    maximumcount([-2, -1, 0, 0, 1]).should eq 2
  end
  it "test_ex3" do
    maximumcount([1, 2, 3, 4]).should eq 4
  end
end
