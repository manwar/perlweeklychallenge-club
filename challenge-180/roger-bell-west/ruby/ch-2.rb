#! /usr/bin/ruby

require 'test/unit'

def trimlist(n, i)
  return n.find_all {|x| x > i}
end

class TestTrimList < Test::Unit::TestCase

  def test_ex1
    assert_equal([4, 5], trimlist([1, 4, 2, 3, 5], 3))
  end

  def test_ex2
    assert_equal([9, 6, 8, 5], trimlist([9, 0, 6, 2, 3, 8, 5], 4))
  end

end
