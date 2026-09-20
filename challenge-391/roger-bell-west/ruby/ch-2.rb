#! /usr/bin/ruby

def arrangebox(a0)
  a = a0.sort
  stack = []
  mx = 1
  0.upto(a.size - 1) do |i|
    stack.push([i, 1])
  end
  while stack.size > 0
    ix, pm = stack.pop
    if pm > mx
            mx = pm
    end
    (ix + 1).upto(a.size - 1) do |j|
      if a[ix][0] < a[j][0] && a[ix][1] < a[j][1]
        stack.push([j, pm + 1])
      end
    end
  end
  mx
end

require 'test/unit'

class TestArrangebox < Test::Unit::TestCase

  def test_ex1
    assert_equal(4, arrangebox([[1, 3], [3, 5], [6, 8], [2, 4]]))
  end

  def test_ex2
    assert_equal(3, arrangebox([[4, 5], [4, 6], [6, 7], [2, 3], [4, 3]]))
  end

  def test_ex3
    assert_equal(1, arrangebox([[5, 5], [5, 5], [5, 5]]))
  end

  def test_ex4
    assert_equal(4, arrangebox([[2, 100], [3, 200], [4, 300], [5, 50], [5, 400]]))
  end

  def test_ex5
    assert_equal(3, arrangebox([[10, 20], [15, 10], [20, 30], [12, 18], [16, 25]]))
  end

end
