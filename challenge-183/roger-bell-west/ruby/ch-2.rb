#! /usr/bin/ruby

require 'test/unit'

require 'time'

def datedifference(d1s, d2s)
  d1 = Time.strptime(d1s + " +0000", '%Y-%m-%d %z')
  d2 = Time.strptime(d2s + " +0000", '%Y-%m-%d %z')
  if d1 > d2 then
    d1, d2 = d2, d1
  end
  yd = d2.year - d1.year
  inter = Time.new(d2.year, d1.month, d1.day, 0, 0, 0, "+0000")
  if d1.month > d2.month ||
     ( d1.month == d2.month && d1.day > d2.day ) then
    inter = Time.new(d2.year-1, d1.month, d1.day, 0, 0, 0, "+0000")
    yd -= 1
  end
  return [yd, (d2 - inter).to_i / 86400]
end

class TestDatedifference < Test::Unit::TestCase

  def test_ex1
    assert_equal([3, 264], datedifference('2019-02-10', '2022-11-01'))
  end

  def test_ex2
    assert_equal([1, 195], datedifference('2020-09-15', '2022-03-29'))
  end

end
