#! /usr/bin/crystal

def ballsandboxes(a)
  boxes = Hash(Int32, Set(Char)).new
  colour = '@'
  a.chars.each_with_index do |c, i|
    if i % 2 == 0
      colour = c
    else
      boxid = c.to_i
      if boxes.has_key?(boxid)
        boxes[boxid].add(colour)
      else
        boxes[boxid] = Set.new([colour])
      end
    end
  end
  boxes.values.select{|x| x.size >= 3}.size
end

require "spec"
describe "ballsandboxes" do
  it "test_ex1" do
    ballsandboxes("G0B1R2R0B0").should eq 1
  end
  it "test_ex2" do
    ballsandboxes("G1R3R6B3G6B1B6R1G3").should eq 3
  end
  it "test_ex3" do
    ballsandboxes("B3B2G1B3").should eq 0
  end
end
