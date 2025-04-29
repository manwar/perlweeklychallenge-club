#! /usr/bin/ruby

require 'set'

def minimumcommon(a, b)
  aa = a.to_set
  bb = b.to_set
  cc = a & b
  if cc.size == 0
    -1
  else
    cc.min
  end
end

require 'test/unit'

class TestMinimumcommon < Test::Unit::TestCase

  def test_ex1
    assert_equal(3, minimumcommon([1, 2, 3, 4], [3, 4, 5, 6]))
  end

  def test_ex2
    assert_equal(2, minimumcommon([1, 2, 3], [2, 4]))
  end

  def test_ex3
    assert_equal(-1, minimumcommon([1, 2, 3, 4], [5, 6, 7, 8]))
  end

end
