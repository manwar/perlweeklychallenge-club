#! /usr/bin/ruby

def matchingmembers(a)
  b = a.sort()
  o = 0
  a.zip(b) do |x, y|
    if x == y then
      o += 1
    end
  end
  return o
end

require 'test/unit'

class TestMatchingmembers < Test::Unit::TestCase

  def test_ex1
    assert_equal(3, matchingmembers([1, 1, 4, 2, 1, 3]))
  end

  def test_ex2
    assert_equal(0, matchingmembers([5, 1, 2, 3, 4]))
  end

  def test_ex3
    assert_equal(5, matchingmembers([1, 2, 3, 4, 5]))
  end

end
