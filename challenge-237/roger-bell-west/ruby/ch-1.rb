#! /usr/bin/ruby

require 'date'

def seizetheday(year, month, weekcount, dayofweek)
  dt = Date.new(year, month, 1)
  wd = dt.wday
  if wd == 0 then
    wd = 7
  end
  if wd != dayofweek then
    dt += (dayofweek - wd + 7) % 7
  end
  if weekcount > 1 then
    dt += 7 * (weekcount - 1)
  end
  if dt.month != month || dt.year != year then
    return 0
  end
  return dt.day
end

require 'test/unit'

class TestSeizetheday < Test::Unit::TestCase

  def test_ex1
    assert_equal(16, seizetheday(2024, 4, 3, 2))
  end

  def test_ex2
    assert_equal(9, seizetheday(2025, 10, 2, 4))
  end

  def test_ex3
    assert_equal(0, seizetheday(2026, 8, 5, 3))
  end

end
