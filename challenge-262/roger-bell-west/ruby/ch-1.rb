#! /usr/bin/ruby

def maxpositivenumber(a)
  return [a.find_all{|c| c > 0}.length,
          a.find_all{|c| c < 0}.length].max
end

require 'test/unit'

class TestMaxpositivenumber < Test::Unit::TestCase

  def test_ex1
    assert_equal(4, maxpositivenumber([-3, 1, 2, -1, 3, -2, 4]))
  end

  def test_ex2
    assert_equal(3, maxpositivenumber([-1, -2, -3, 1]))
  end

  def test_ex3
    assert_equal(2, maxpositivenumber([1, 2]))
  end

end
