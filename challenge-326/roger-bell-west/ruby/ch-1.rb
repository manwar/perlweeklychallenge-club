#! /usr/bin/ruby

require 'date'

def dayoftheyear(a)
  Date.parse(a).yday
end

require 'test/unit'

class TestDayoftheyear < Test::Unit::TestCase

  def test_ex1
    assert_equal(33, dayoftheyear('2025-02-02'))
  end

  def test_ex2
    assert_equal(100, dayoftheyear('2025-04-10'))
  end

  def test_ex3
    assert_equal(250, dayoftheyear('2025-09-07'))
  end

end
