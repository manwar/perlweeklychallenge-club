#! /usr/bin/ruby

require 'test/unit'

require 'time'

def s2date(ds)
  /^(\d+)\-(\d+)$/ =~ ds
  return Time.new(2022, $2, $1, 0, 0, 0, "+0000")
end

def daystogether(a, b)
  starts = [s2date(a[0]), s2date(b[0])].sort
  ends = [s2date(a[1]), s2date(b[1])].sort
  if ends[0] >= starts[1] then
    return (ends[0]-starts[1]).to_i/86400+1
  else
    return 0
  end
end

class TestDaystogether < Test::Unit::TestCase

  def test_ex1
    assert_equal(4,
                 daystogether(["12-01", "20-01"], ["15-01", "18-01"]))
  end

  def test_ex2
    assert_equal(0,
                 daystogether(["02-03", "12-03"], ["13-03", "14-03"]))
  end

  def test_ex3
    assert_equal(2,
                 daystogether(["02-03", "12-03"], ["11-03", "15-03"]))
  end

  def test_ex4
    assert_equal(4,
                 daystogether(["30-03", "05-04"], ["28-03", "02-04"]))
  end

end
