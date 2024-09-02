#! /usr/bin/ruby

def luckyinteger(a)
  c = Hash.new
  c.default = 0
  a.each do |n|
    c[n] += 1
  end
  c1 = c.values.sort.reverse
  c2 = c.keys.sort.reverse
  c1.each do |v1|
    c2.each do |v2|
      if c[v2] == v1 && v1 == v2
        return v2
      end
    end
  end
  -1
end

require 'test/unit'

class TestLuckyinteger < Test::Unit::TestCase

  def test_ex1
    assert_equal(2, luckyinteger([2, 2, 3, 4]))
  end

  def test_ex2
    assert_equal(3, luckyinteger([1, 2, 2, 3, 3, 3]))
  end

  def test_ex3
    assert_equal(-1, luckyinteger([1, 1, 1, 3]))
  end

end
