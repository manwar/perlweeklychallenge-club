#! /usr/bin/ruby

def separatedigits(a)
  out = []
  a.each do |n|
    m = n
    v = []
    while m > 0 do
      m, i = m.divmod(10)
      v.push(i)
    end
    out += v.reverse
  end
  return out
end

require 'test/unit'

class TestSeparatedigits < Test::Unit::TestCase

  def test_ex1
    assert_equal([1, 3, 4, 5, 6], separatedigits([1, 34, 5, 6]))
  end

  def test_ex2
    assert_equal([1, 2, 4, 5, 1, 6, 0], separatedigits([1, 24, 51, 60]))
  end

end
