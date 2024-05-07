#! /usr/bin/ruby

def numbergame(a0)
  out = []
  a = a0.sort
  a.each_slice(2) do |s|
    out.push(s[1])
    out.push(s[0])
  end
  return out
end

require 'test/unit'

class TestNumbergame < Test::Unit::TestCase

  def test_ex1
    assert_equal([3, 2, 5, 4], numbergame([2, 5, 3, 4]))
  end

  def test_ex2
    assert_equal([1, 1, 4, 3, 6, 4, 9, 6], numbergame([9, 4, 1, 3, 6, 4, 6, 1]))
  end

  def test_ex3
    assert_equal([2, 1, 3, 2], numbergame([1, 2, 2, 3]))
  end

end
