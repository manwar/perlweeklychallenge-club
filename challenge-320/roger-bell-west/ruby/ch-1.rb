#! /usr/bin/ruby

def maximumcount(a)
  pos = 0
  neg = 0
  a.each do |n|
    if n > 0
      pos += 1
    elsif n < 0
      neg += 1
    end
  end
  [pos, neg].max
end

require 'test/unit'

class TestMaximumcount < Test::Unit::TestCase

  def test_ex1
    assert_equal(3, maximumcount([-3, -2, -1, 1, 2, 3]))
  end

  def test_ex2
    assert_equal(2, maximumcount([-2, -1, 0, 0, 1]))
  end

  def test_ex3
    assert_equal(4, maximumcount([1, 2, 3, 4]))
  end

end
