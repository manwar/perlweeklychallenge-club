#! /usr/bin/ruby

def floorsum(a)
  n = 0
  a.each do |iv|
    a.each do |jv|
      n += iv.div(jv)
    end
  end
  return n
end

require 'test/unit'

class TestFloorsum < Test::Unit::TestCase

  def test_ex1
    assert_equal(10, floorsum([2, 5, 9]))
  end

  def test_ex2
    assert_equal(49, floorsum([7, 7, 7, 7, 7, 7, 7]))
  end

end
