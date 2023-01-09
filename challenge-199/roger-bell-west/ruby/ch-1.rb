#! /usr/bin/ruby

require 'test/unit'

def goodpairs(l)
  c = 0
  k = Hash.new(0)
  l.each do |i|
    k[i] += 1
  end
  k.values.each do |v|
    c += v * (v - 1)
  end
  return c / 2
end

class TestGoodpairs < Test::Unit::TestCase

  def test_ex1
    assert_equal(4, goodpairs([1, 2, 3, 1, 1, 3]))
  end

  def test_ex2
    assert_equal(0, goodpairs([1, 2, 3]))
  end

  def test_ex3
    assert_equal(6, goodpairs([1, 1, 1, 1]))
  end

end
