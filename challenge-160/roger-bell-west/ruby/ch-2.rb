#! /usr/bin/ruby

require 'test/unit'

def equilibriumindex(s)
  sm=s.sum
  sa=0
  s.each_with_index do |v,i|
    sa += v
    if sa == sm then
      return i
    end
    sa += v
  end
  return -1
end

class TestEquilibriumindex < Test::Unit::TestCase

  def test_ex1
    assert_equal(3,
                 equilibriumindex([1,3,5,7,9]))
  end

  def test_ex2
    assert_equal(-1,
                 equilibriumindex([1,2,3,4,5]))
  end

  def test_ex3
    assert_equal(1,
                 equilibriumindex([2,4,2]))
  end

end
