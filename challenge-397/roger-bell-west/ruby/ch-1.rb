#! /usr/bin/ruby

require 'set'

def absentsmallestpositive(a)
  tot = a.sum
  ex = a.to_set
  mul = a.length
  n = 1
  while true do
    if n * mul > tot && !ex.include?(n)
      return n
    end
    n += 1
  end
end

require 'test/unit'

class TestAbsentsmallestpositive < Test::Unit::TestCase

  def test_ex1
    assert_equal(7, absentsmallestpositive([1, 2, 4, 5, 6]))
  end

  def test_ex2
    assert_equal(1, absentsmallestpositive([-5, -2, -1, 3]))
  end

  def test_ex3
    assert_equal(4, absentsmallestpositive([1, 2, 3]))
  end

  def test_ex4
    assert_equal(6, absentsmallestpositive([2, 3, 7, 8]))
  end

  def test_ex5
    assert_equal(4, absentsmallestpositive([1, 1, 1, 10]))
  end

end
