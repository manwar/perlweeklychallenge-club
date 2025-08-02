#! /usr/bin/ruby

def contiguousarray(a)
  ((a.size + 1).div(2) * 2).step(2, -2) do |l|
    0.upto(a.size - l) do |start|
      if a[start, l].sum * 2 == l
        return l
      end
    end
  end
  0
end

require 'test/unit'

class TestContiguousarray < Test::Unit::TestCase

  def test_ex1
    assert_equal(2, contiguousarray([1, 0]))
  end

  def test_ex2
    assert_equal(2, contiguousarray([0, 1, 0]))
  end

  def test_ex3
    assert_equal(0, contiguousarray([0, 0, 0, 0, 0]))
  end

  def test_ex4
    assert_equal(4, contiguousarray([0, 1, 0, 0, 1, 0]))
  end

end
