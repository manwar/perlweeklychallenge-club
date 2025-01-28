#! /usr/bin/ruby

def oddsum(a)
  out = a.sum
  l = 3
  while l <= a.length do
    a.each_cons(l) do |s|
      out += s.sum
    end
    l += 2
  end
  out
end

require 'test/unit'

class TestOddsum < Test::Unit::TestCase

  def test_ex1
    assert_equal(77, oddsum([2, 5, 3, 6, 4]))
  end

  def test_ex2
    assert_equal(4, oddsum([1, 3]))
  end

end
