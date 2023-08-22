#! /usr/bin/ruby

def notminmax(a)
  mn = a.min
  mx = a.max
  return a.find_all {|x| x > mn and x < mx}
end

require 'test/unit'

class TestNotminmax < Test::Unit::TestCase

  def test_ex1
    assert_equal([3, 2], notminmax([3, 2, 1, 4]))
  end

  def test_ex2
    assert_equal([], notminmax([3, 1]))
  end

  def test_ex3
    assert_equal([2], notminmax([2, 1, 3]))
  end

end
