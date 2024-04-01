#! /usr/bin/ruby

def countequaldivisible(a, k)
  s = 0
  0.upto(a.length - 1).to_a.combination(2) do |c|
    if a[c[0]] == a[c[1]] && c[0] * c[1] % k == 0 then
      s += 1
    end
  end
  return s
end

require 'test/unit'

class TestCountequaldivisible < Test::Unit::TestCase

  def test_ex1
    assert_equal(4, countequaldivisible([3, 1, 2, 2, 2, 1, 3], 2))
  end

  def test_ex2
    assert_equal(0, countequaldivisible([1, 2, 3], 1))
  end

end
