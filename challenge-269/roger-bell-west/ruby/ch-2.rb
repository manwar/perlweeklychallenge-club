#! /usr/bin/ruby

def distributeelements(a)
  x = [a[0]]
  y = [a[1]]
  (2 ... a.size).each do |i|
    n = a[i]
    if x[-1] > y[-1]
      x.push(n)
    else
      y.push(n)
    end
  end
  x.concat(y)
  x
end

require 'test/unit'

class TestDistributeelements < Test::Unit::TestCase

  def test_ex1
    assert_equal([2, 3, 4, 5, 1], distributeelements([2, 1, 3, 4, 5]))
  end

  def test_ex2
    assert_equal([3, 4, 2], distributeelements([3, 2, 4]))
  end

  def test_ex3
    assert_equal([5, 3, 4, 8], distributeelements([5, 4, 3, 8]))
  end

end
