#! /usr/bin/crystal

def groupposition(a)
  mx = Array({Char, Int32}).new
  lc = "z"
  a.chars.each_with_index do |c, i|
    if i == 0
      lc = (c.ord + 1).chr
    end
    if lc == c
      mc = mx.size
      mx[mc - 1] = {mx[mc - 1][0], mx[mc - 1][1] + 1}
    else
      mx.push({c, 1})
      lc = c
    end
  end
  out = Array(String).new
  mx.each do |ms|
    if ms[1] >= 3
      out.push(ms[0].to_s * ms[1])
    end
  end
  out
end

require "spec"
describe "groupposition" do
  it "test_ex1" do
    groupposition("abccccd").should eq ["cccc"]
  end
  it "test_ex2" do
    groupposition("aaabcddddeefff").should eq ["aaa", "dddd", "fff"]
  end
  it "test_ex3" do
    groupposition("abcdd").should eq [] of String
  end
end
