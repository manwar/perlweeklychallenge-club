#! /usr/bin/ruby

def minabsdiff(a)
  b = a.sort
  out = []
  mindiff = 1 + b[b.size - 1] - b[0]
  b.each_cons(2) do |c|
    d = c[1] - c[0]
    if d < mindiff
      out = []
      mindiff = d
    end
    if d == mindiff
      out.push(c)
    end
  end
  out
end

require 'test/unit'

class TestMinabsdiff < Test::Unit::TestCase

  def test_ex1
    assert_equal([[1, 2], [2, 3], [3, 4]], minabsdiff([4, 2, 1, 3]))
  end

  def test_ex2
    assert_equal([[10, 20], [20, 30]], minabsdiff([10, 100, 20, 30]))
  end

  def test_ex3
    assert_equal([[-2, 0]], minabsdiff([-5, -2, 0, 3]))
  end

  def test_ex4
    assert_equal([[1, 3]], minabsdiff([8, 1, 15, 3]))
  end

  def test_ex5
    assert_equal([[9, 12], [12, 15]], minabsdiff([12, 5, 9, 1, 15]))
  end

end
