#! /usr/bin/ruby

def percentageofcharacter(a, c)
  d = a.size
  n = 100 * a.count(c)
  (n + d.div(2)).div(d)
end

require 'test/unit'

class TestPercentageofcharacter < Test::Unit::TestCase

  def test_ex1
    assert_equal(25, percentageofcharacter('perl', 'e'))
  end

  def test_ex2
    assert_equal(50, percentageofcharacter('java', 'a'))
  end

  def test_ex3
    assert_equal(0, percentageofcharacter('python', 'm'))
  end

  def test_ex4
    assert_equal(67, percentageofcharacter('ada', 'a'))
  end

  def test_ex5
    assert_equal(22, percentageofcharacter('ballerina', 'l'))
  end

  def test_ex6
    assert_equal(13, percentageofcharacter('analitik', 'k'))
  end

end
