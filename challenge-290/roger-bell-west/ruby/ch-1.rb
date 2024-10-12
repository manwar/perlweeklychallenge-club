#! /usr/bin/ruby

def doubleexist(a)
  a.combination(2).each do |i|
    if i[0] == 2 * i[1] || i[1] == 2 * i[0]
      return true
    end
  end
  false
end

require 'test/unit'

class TestDoubleexist < Test::Unit::TestCase

  def test_ex1
    assert_equal(true, doubleexist([6, 2, 3, 3]))
  end

  def test_ex2
    assert_equal(false, doubleexist([3, 1, 4, 13]))
  end

  def test_ex3
    assert_equal(true, doubleexist([2, 1, 4, 2]))
  end

end
