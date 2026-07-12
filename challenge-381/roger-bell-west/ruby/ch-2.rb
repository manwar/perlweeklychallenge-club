#! /usr/bin/ruby

def smallergreaterelement(a)
  mn = a.min
  mx = a.max
  return a.find_all {|x| x > mn and x < mx}.length
end

require 'test/unit'

class TestSmallergreaterelement < Test::Unit::TestCase

  def test_ex1
    assert_equal(0, smallergreaterelement([2, 4]))
  end

  def test_ex2
    assert_equal(0, smallergreaterelement([1, 1, 1, 1]))
  end

  def test_ex3
    assert_equal(2, smallergreaterelement([1, 1, 4, 8, 12, 12]))
  end

  def test_ex4
    assert_equal(2, smallergreaterelement([3, 6, 6, 9]))
  end

  def test_ex5
    assert_equal(3, smallergreaterelement([0, -5, 10, -2, 4]))
  end

end
