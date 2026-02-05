#! /usr/bin/ruby

def digitalroot(a)
  count = 0
  value = a
  while value > 9
    p = 0
    while value > 0
      p += value % 10
      value = value.div(10)
    end
    value = p
    count += 1
  end
  [count, value]
end

require 'test/unit'

class TestDigitalroot < Test::Unit::TestCase

  def test_ex1
    assert_equal([2, 2], digitalroot(38))
  end

  def test_ex2
    assert_equal([0, 7], digitalroot(7))
  end

  def test_ex3
    assert_equal([2, 9], digitalroot(999))
  end

  def test_ex4
    assert_equal([3, 1], digitalroot(1999999999))
  end

  def test_ex5
    assert_equal([1, 3], digitalroot(101010))
  end

end
