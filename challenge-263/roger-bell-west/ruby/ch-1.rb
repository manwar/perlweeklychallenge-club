#! /usr/bin/ruby

def targetindex(a0, k)
  a = a0.sort
  out = []
  a.each_with_index do |v, i|
    if v == k then
      out.push(i)
    end
  end
  return out
end      

require 'test/unit'

class TestTargetindex < Test::Unit::TestCase

  def test_ex1
    assert_equal([1, 2], targetindex([1, 5, 3, 2, 4, 2], 2))
  end

  def test_ex2
    assert_equal([], targetindex([1, 2, 4, 3, 5], 6))
  end

  def test_ex3
    assert_equal([4], targetindex([5, 3, 2, 4, 2, 1], 4))
  end

end
