#! /usr/bin/ruby

require 'set'

def thirdmaximum(a)
  p = Set.new(a).to_a.sort.reverse
  if p.size > 2
    p[2]
  else
    p[0]
  end
end

require 'test/unit'

class TestThirdmaximum < Test::Unit::TestCase

  def test_ex1
    assert_equal(4, thirdmaximum([5, 6, 4, 1]))
  end

  def test_ex2
    assert_equal(5, thirdmaximum([4, 5]))
  end

  def test_ex3
    assert_equal(1, thirdmaximum([1, 2, 2, 3]))
  end

end
