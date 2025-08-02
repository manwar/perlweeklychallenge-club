#! /usr/bin/ruby

def reverseequals(a, b)
  if a == b
    return true
  end
  0.upto(a.length - 2) do |i|
    (i + 1).upto(a.length - 1) do |j|
      c = a.clone
      i.upto(j) do |x|
        c[x] = a[j - (x - i)]
      end
      if c == b
        return true
      end
    end
  end
  false
end

require 'test/unit'

class TestReverseequals < Test::Unit::TestCase

  def test_ex1
    assert_equal(true, reverseequals([3, 2, 1, 4], [1, 2, 3, 4]))
  end

  def test_ex2
    assert_equal(false, reverseequals([1, 3, 4], [4, 1, 3]))
  end

  def test_ex3
    assert_equal(true, reverseequals([2], [2]))
  end

end
