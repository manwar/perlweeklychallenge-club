#! /usr/bin/ruby

require 'test/unit'

def h_index(c0)
  c = c0.sort.reverse
  h = 0
  c.each_with_index do |x, i|
    if i + 1 <= x then
      h = i + 1
    else
      break
    end
  end
  return h
end

class TestH_index < Test::Unit::TestCase

  def test_ex1
    assert_equal(4, h_index([10, 8, 5, 4, 3]))
  end

  def test_ex2
    assert_equal(3, h_index([25, 8, 5, 3, 3]))
  end

end
