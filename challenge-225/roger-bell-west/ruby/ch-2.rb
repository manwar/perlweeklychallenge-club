#! /usr/bin/ruby

def leftrightsumdiff(a)
  al = a.length - 1
  left = [0]
  right = [0]
  0.upto(al - 1) do |i|
    left.push(left[i] + a[i])
    right.push(right[i] + a[al - i])
  end
  return left.zip(right.reverse).map {|x| (x[0]-x[1]).abs}
end

require 'test/unit'

class TestLeftrightsumdiff < Test::Unit::TestCase

  def test_ex1
    assert_equal([15, 1, 11, 22], leftrightsumdiff([10, 4, 8, 3]))
  end

  def test_ex2
    assert_equal([0], leftrightsumdiff([1]))
  end

  def test_ex3
    assert_equal([14, 11, 6, 1, 10], leftrightsumdiff([1, 2, 3, 4, 5]))
  end

end
