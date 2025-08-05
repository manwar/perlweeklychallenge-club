#! /usr/bin/ruby

require 'set'

def straightline(a)
  b = a.to_set.to_a
  if b.length < 3
    return true
  end
  p = b[0][0]
  q = b[1][0] - b[0][0]
  r = b[0][1]
  s = b[1][1] - b[0][1]
  b.slice(2, b.length).each do |tpair|
    if q == 0.0 and tpair[0] != b[0][0]
      return false
    end
    if s == 0.0 and tpair[1] != b[0][1]
      return false
    end
    if q != 0.0 and s != 0.0
      n1 = (tpair[0] - p) / q
      n2 = (tpair[1] - r) / s
      if n1 != n2
        return false
      end
    end
  end
  true
end

require 'test/unit'

class TestStraightline < Test::Unit::TestCase

  def test_ex1
    assert_equal(true, straightline([[2, 1], [2, 3], [2, 5]]))
  end

  def test_ex2
    assert_equal(true, straightline([[1, 4], [3, 4], [10, 4]]))
  end

  def test_ex3
    assert_equal(false, straightline([[0, 0], [1, 1], [2, 3]]))
  end

  def test_ex4
    assert_equal(true, straightline([[1, 1], [1, 1], [1, 1]]))
  end

end
