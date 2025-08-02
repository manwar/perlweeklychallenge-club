#! /usr/bin/crystal
require "spec"
describe "checkcolor" do
  it "test_ex1" do
    checkcolor("d3").should eq true
  end
  it "test_ex2" do
    checkcolor("g5").should eq false
  end
  it "test_ex3" do
    checkcolor("e6").should eq true
  end
end

def cs2xy(a)
  c = a.chars
  x = c[0].ord - 'a'.ord
  y = c[1].ord - '1'.ord
  [x, y]
end

def checkcolor(a)
  xy = cs2xy(a)
  (xy[0] + xy[1]) % 2 == 1
end
