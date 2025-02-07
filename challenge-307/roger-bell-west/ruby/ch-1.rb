#! /usr/bin/ruby

def checkorder(a)
  b = a.sort
  out = []
  a.each_with_index do |c, i|
    if b[i] != c
      out.push(i)
    end
  end
  out
end

require 'test/unit'

class TestCheckorder < Test::Unit::TestCase

  def test_ex1
    assert_equal([0, 2, 3, 4], checkorder([5, 2, 4, 3, 1]))
  end

  def test_ex2
    assert_equal([1, 3], checkorder([1, 2, 1, 1, 3]))
  end

  def test_ex3
    assert_equal([0, 1, 3], checkorder([3, 1, 3, 2, 3]))
  end

end
