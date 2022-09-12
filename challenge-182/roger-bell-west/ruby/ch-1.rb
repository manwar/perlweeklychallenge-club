#! /usr/bin/ruby

require 'test/unit'

def maxindex(n)
  mxv = 0
  mxi = 0
  n.each_with_index do |v, i|
    if i == 0 || v > mxv then
      mxv = v
      mxi = i
    end
  end
  return mxi
end

class TestMaxindex < Test::Unit::TestCase

  def test_ex1
    assert_equal(2, maxindex([5, 2, 9, 1, 7, 6]))
  end

  def test_ex2
    assert_equal(4, maxindex([4, 2, 3, 1, 5, 0]))
  end

  def test_ex3
    assert_equal(0, maxindex([4, 2, 3, 1, 4, 0]))
  end

end
