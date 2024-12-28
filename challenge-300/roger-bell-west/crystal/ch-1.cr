#! /usr/bin/crystal

def beautifularrangement(a)
  precalc = Array.new(a + 1) { Array.new(a + 1, false) }
  1.upto(a) do |i|
    i.step(to: a, by: i) do |j|
      precalc[i][j] = true
      precalc[j][i] = true
    end
  end
  ct = 0
  stack = Array(Array(Int32)).new
  stack.push((1 .. a).to_a)
  while stack.size > 0
    trail = stack.pop
    if trail.size == 1
      ct += 1
    else
      p = a - trail.size + 2
      trail.each do |i|
        if precalc[i][p]
          tt = trail.select{|x| x != i}
          stack.push(tt)
        end
      end
    end
  end
  ct
end

require "spec"
describe "beautifularrangement" do
  it "test_ex1" do
    beautifularrangement(2).should eq 2
  end
  it "test_ex2" do
    beautifularrangement(1).should eq 1
  end
  it "test_ex3" do
    beautifularrangement(10).should eq 700
  end
  it "test_ex4" do
    beautifularrangement(20).should eq 1939684
  end
end
