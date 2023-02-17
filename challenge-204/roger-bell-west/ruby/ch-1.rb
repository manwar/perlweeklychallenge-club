#! /usr/bin/ruby

require 'test/unit'

def monotonicarray(l)
  d = []
  l.each_cons(2) do |i|
    d.push(i[1] - i[0])
  end
  return d.max * d.min >= 0
end

class TestMonotonicarray < Test::Unit::TestCase

  def test_ex1
    assert_equal(true, monotonicarray([1, 2, 2, 3]))
  end

  def test_ex2
    assert_equal(false, monotonicarray([1, 3, 2]))
  end

  def test_ex3
    assert_equal(true, monotonicarray([6, 5, 5, 4]))
  end

end
