#! /usr/bin/ruby

def sortedsquares(lst)
  return lst.collect {|x| x * x}.sort
end

require 'test/unit'

class TestSortedsquares < Test::Unit::TestCase

  def test_ex1
    assert_equal([0, 1, 4, 9, 16], sortedsquares([-2, -1, 0, 3, 4]))
  end

  def test_ex2
    assert_equal([1, 9, 16, 25, 36], sortedsquares([5, -4, -1, 3, 6]))
  end

end
