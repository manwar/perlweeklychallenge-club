#! /usr/bin/ruby

def twicelargest(a)
  p = a.sort.reverse
  if p[0] >= 2 * p[1]
    a.each_with_index do |c, i|
      if c == p[0]
        return i
      end
    end
  end
  -1
end

require 'test/unit'

class TestTwicelargest < Test::Unit::TestCase

  def test_ex1
    assert_equal(1, twicelargest([2, 4, 1, 0]))
  end

  def test_ex2
    assert_equal(-1, twicelargest([1, 2, 3, 4]))
  end

end
