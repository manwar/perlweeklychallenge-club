#! /usr/bin/crystal

def aliendictionary(a, dc)
  mxl = a.map { |x| x.size }.max
  dh = Hash(Char, Int64).new
  dc.each_with_index do |c, i|
    dh[c] = i.to_i64
  end
  b = a
  numerics = Hash(String, Int64).new
  b.each do |w|
    n = 0.to_i64
    cc = w.chars
    0.upto(mxl - 1) do |i|
      n *= 27.to_i64
      if i < w.size
        n += dh[cc[i]]
      end
    end
    numerics[w] = n
  end
  b.sort! do |i, j|
    numerics[i] <=> numerics[j]
  end
  b
end

require "spec"
describe "aliendictionary" do
  it "test_ex1" do
    aliendictionary(["perl", "python", "raku"], ['h', 'l', 'a', 'b', 'y', 'd', 'e', 'f', 'g', 'i', 'r', 'k', 'm', 'n', 'o', 'p', 'q', 'j', 's', 't', 'u', 'v', 'w', 'x', 'c', 'z']).should eq ["raku", "python", "perl"]
  end
  it "test_ex2" do
    aliendictionary(["the", "weekly", "challenge"], ['c', 'o', 'r', 'l', 'd', 'a', 'b', 't', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'm', 'n', 'p', 'q', 's', 'w', 'u', 'v', 'x', 'y', 'z']).should eq ["challenge", "the", "weekly"]
  end
end
