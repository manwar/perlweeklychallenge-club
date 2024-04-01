#! /usr/bin/ruby

require 'set'

def multiplybytwo(a, start)
  p = Set.new(a)
  v = start
  while p.include?(v) do
    v *= 2
  end
  return v
end

require 'test/unit'

class TestMultiplybytwo < Test::Unit::TestCase

  def test_ex1
    assert_equal(24, multiplybytwo([5, 3, 6, 1, 12], 3))
  end

  def test_ex2
    assert_equal(8, multiplybytwo([1, 2, 4, 3], 1))
  end

  def test_ex3
    assert_equal(2, multiplybytwo([5, 6, 7], 2))
  end

end
