#! /usr/bin/ruby

def arraymedian(a, b)
  nn = a
  b.each do |n|
    nn.push(n)
  end
  nn = nn.sort()
  i = nn.size.div(2)
  if nn.size % 2 == 0
    (nn[i - 1] + nn[i]).to_f / 2.0
  else
    nn[i].to_f
  end
end

require 'test/unit'

class TestArraymedian < Test::Unit::TestCase

  def test_ex1
    assert_equal(3, arraymedian([2], [4]))
  end

  def test_ex2
    assert_equal(7, arraymedian([1, 2, 3], [7, 8, 9, 10]))
  end

  def test_ex3
    assert_equal(25, arraymedian([], [10, 20, 30, 40]))
  end

  def test_ex4
    assert_equal(4.5, arraymedian([100], [1, 2, 3, 4, 5, 6, 7]))
  end

  def test_ex5
    assert_equal(2, arraymedian([1, 2, 2], [2, 2, 3]))
  end

end
