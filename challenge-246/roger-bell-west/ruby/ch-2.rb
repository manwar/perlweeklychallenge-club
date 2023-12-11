#! /usr/bin/ruby

def linearrecurrencesecondorder(seq)
  a = seq[0..2]
  b = seq[1..3]
  c = seq[2..4]
  q = (b[2] * a[0] - b[0] * a[2]) / (b[1] * a[0] - b[0] * a[1])
  p = (a[2] - a[1] * q) / a[0]
  return p * a[0] + q * a[1] == a[2] &&
         p * b[0] + q * b[1] == b[2] &&
         p * c[0] + q * c[1] == c[2]
end

require 'test/unit'

class TestLinearrecurrencesecondorder < Test::Unit::TestCase

  def test_ex1
    assert_equal(true, linearrecurrencesecondorder([1, 1, 2, 3, 5]))
  end

  def test_ex2
    assert_equal(false, linearrecurrencesecondorder([4, 2, 4, 5, 7]))
  end

  def test_ex3
    assert_equal(true, linearrecurrencesecondorder([4, 1, 2, -3, 8]))
  end

end

