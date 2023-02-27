#! /usr/bin/ruby

require 'test/unit'

def maximumxor(l)
  m = []
  l.combination(2) do |c|
    m.push(c[0] ^ c[1])
  end
  return m.max
end

class TestMaximumxor < Test::Unit::TestCase

  def test_ex1
    assert_equal(7, maximumxor([1, 2, 3, 4, 5, 6, 7]))
  end

  def test_ex2
    assert_equal(7, maximumxor([2, 4, 1, 3]))
  end

  def test_ex3
    assert_equal(15, maximumxor([10, 5, 7, 12, 8]))
  end

end
