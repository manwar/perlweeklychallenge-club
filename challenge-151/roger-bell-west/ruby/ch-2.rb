#! /usr/bin/ruby

require 'test/unit'

def plan(houses)
  terminal=houses.length-2
  b=[[0]]
  reward=0
  while b.length > 0 do
    c=b.pop
    if c[-1] >= terminal then
      reward=[reward,c.map{|i| houses[i]}.sum].max
    else
      (c[-1]+2).upto(c[-1]+3) do |n|
        if n >= houses.length then
          break
        end
        j=Array.new(c)
        j.push(n)
        b.push(j)
      end
    end
  end
  return reward
end

class TestPlan < Test::Unit::TestCase

  def test_ex1
    assert_equal(7,plan([2, 4, 5]))
  end

  def test_ex2
    assert_equal(13,plan([4, 2, 3, 6, 5, 3]))
  end

end
