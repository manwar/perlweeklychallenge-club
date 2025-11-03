#! /usr/bin/ruby

def peakpositions(a)
  out = []
  a.each_with_index do |x, i|
    if (i == 0 || x > a[i - 1]) && (i == a.size() - 1 || x > a[i + 1])
      out.push(i)
    end
  end
  out
end

require 'test/unit'

class TestPeakpositions < Test::Unit::TestCase

  def test_ex1
    assert_equal([1], peakpositions([1, 3, 2]))
  end

  def test_ex2
    assert_equal([2], peakpositions([2, 4, 6, 5, 3]))
  end

  def test_ex3
    assert_equal([2, 4], peakpositions([1, 2, 3, 2, 4, 1]))
  end

  def test_ex4
    assert_equal([0], peakpositions([5, 3, 1]))
  end

  def test_ex5
    assert_equal([1, 3, 5], peakpositions([1, 5, 1, 5, 1, 5, 1]))
  end

end
