#! /usr/bin/crystal

def alternatecase(a)
  uppers = a.chars.map{|c| c.uppercase?}
  queue = Deque(Tuple(Array(Bool), Int32)).new
  queue.push({uppers, 0})
  while queue.size > 0
    up, ct = queue.shift
    swaps = Array(Int32).new
    0.upto(up.size - 2) do |i|
      if up[i] == up[i + 1]
        if i > 0
          swaps.push(i - 1)
        end
        if i < up.size - 2
          swaps.push(i + 1)
        end
      end
    end
    if swaps.size == 0
      return ct
    end
    swaps.each do |sw|
      uq = up.clone
      uq[sw], uq[sw + 1] = uq[sw + 1], uq[sw]
      queue.push({uq, ct + 1})
    end
  end
  0
end

require "spec"
describe "alternatecase" do
  it "test_ex1" do
    alternatecase("aAbB").should eq 0
  end
  it "test_ex2" do
    alternatecase("AAbb").should eq 1
  end
  it "test_ex3" do
    alternatecase("AAAbbb").should eq 3
  end
  it "test_ex4" do
    alternatecase("aABb").should eq 1
  end
  it "test_ex5" do
    alternatecase("bBBAaa").should eq 2
  end
end
