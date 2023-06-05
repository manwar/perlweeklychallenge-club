#! /usr/bin/ruby

def travelexpenditure(costs, days0)
  days = days0.sort
  validities = [1, 7, 30]
  stack = []
  stack.push([0, days])
  cheapest = days.length * costs[0]
  while stack.length > 0 do
    c = stack.shift
    if c[1].length == 0 then
      if c[0] < cheapest then
        cheapest = c[0]
      end
    else
      if c[0] >= cheapest then
        next
      end
      start = c[1][0]
      0.upto(2) do |i|
        ed = start + validities[i] - 1
        dtd = c[1].find_all {|x| x > ed}
        stack.push([c[0] + costs[i], dtd])
      end
    end
  end
  return cheapest
end

require 'test/unit'

class TestTravelexpenditure < Test::Unit::TestCase

  def test_ex1
    assert_equal(11, travelexpenditure([2, 7, 25], [1, 5, 6, 7, 9, 15]))
  end

  def test_ex2
    assert_equal(20, travelexpenditure([2, 7, 25], [1, 2, 3, 5, 7, 10, 11, 12, 14, 20, 30, 31]))
  end

end
