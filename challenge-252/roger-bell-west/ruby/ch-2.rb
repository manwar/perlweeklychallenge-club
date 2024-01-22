#! /usr/bin/ruby

def uniquesumzero(n)
    if n == 1 then
        return [0]
    end
    p = Array.new(n - 1) {|i| i + 1}
    p.push(-n * (n-1) / 2)
    return p
end

require 'test/unit'

class TestUniquesumzero < Test::Unit::TestCase

  def test_ex1
    assert_equal([1, 2, 3, 4, -10], uniquesumzero(5))
  end

  def test_ex2
    assert_equal([1, 2, -3], uniquesumzero(3))
  end

  def test_ex3
    assert_equal([0], uniquesumzero(1))
  end

end
