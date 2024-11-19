#! /usr/bin/crystal

def matchsticksquare(a)
  perimeter = a.sum
  if perimeter % 4 != 0
    return false
  end
  side = perimeter / 4
  ss = a.sort.reverse
  sidesleft = 4
  lengthleft = side
  while true
    leftover = [] of Int32
    ss.each do |m|
      if m > side
        return false
      end
      if m <= lengthleft
        lengthleft -= m
        if lengthleft == 0
          sidesleft -= 1
          lengthleft = side
        end
      else
        leftover.push(m)
      end
    end
    if leftover.size == 0
      break
    end
    ss = leftover
  end
  if sidesleft == 0 && lengthleft == side
    return true
  end
  false
end

require "spec"
describe "matchsticksquare" do
  it "test_ex1" do
    matchsticksquare([1, 2, 2, 2, 1]).should eq true
  end
  it "test_ex2" do
    matchsticksquare([2, 2, 2, 4]).should eq false
  end
  it "test_ex3" do
    matchsticksquare([2, 2, 2, 2, 4]).should eq false
  end
  it "test_ex4" do
    matchsticksquare([3, 4, 1, 4, 3, 1]).should eq true
  end
end
