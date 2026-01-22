#! /usr/bin/ruby

def a2n(a)
  t = 0
  a.each do |d|
    t *= 10
    t += d
  end
  t
end

def kaprekarconstant(a)
  ct = 0
  b = a
  while b != 6174
    if b == 0
      return -1
    end
    digits = []
    0.upto(3) do
      (b, d) = b.divmod(10)
      digits.push(d)
    end
    digits = digits.sort()
    stigid = digits.reverse()
    b = a2n(stigid) - a2n(digits)
    ct += 1
  end
  ct
end

require 'test/unit'

class TestKaprekarconstant < Test::Unit::TestCase

  def test_ex1
    assert_equal(3, kaprekarconstant(3524))
  end

  def test_ex2
    assert_equal(0, kaprekarconstant(6174))
  end

  def test_ex3
    assert_equal(5, kaprekarconstant(9998))
  end

  def test_ex4
    assert_equal(4, kaprekarconstant(1001))
  end

  def test_ex5
    assert_equal(4, kaprekarconstant(9000))
  end

  def test_ex6
    assert_equal(-1, kaprekarconstant(1111))
  end

end
