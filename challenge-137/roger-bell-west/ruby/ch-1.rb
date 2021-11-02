#! /usr/bin/ruby

def p(y)
  return (y+y.div(4)-y.div(100)+y.div(400)) % 7
end

def longyear()
  return 1900.upto(2100).find_all {|y| p(y-1)==3 || p(y)==4}
end

require 'test/unit'

class TestLongyear < Test::Unit::TestCase

  def test_ex1
    assert_equal([1903, 1908, 1914, 1920, 1925,
                  1931, 1936, 1942, 1948, 1953,
                  1959, 1964, 1970, 1976, 1981,
                  1987, 1992, 1998, 2004, 2009,
                  2015, 2020, 2026, 2032, 2037,
                  2043, 2048, 2054, 2060, 2065,
                  2071, 2076, 2082, 2088, 2093,
                  2099],longyear())
  end

end
