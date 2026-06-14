#! /usr/bin/ruby

def reverseexistence(a)
  c = a.chars.reverse
  c.each_cons(2) do |d|
    sample = d[0] + d[1]
    if !a.index(sample).nil?
      return true
    end
  end
  false
end

require 'test/unit'

class TestReverseexistence < Test::Unit::TestCase

  def test_ex1
    assert_equal(true, reverseexistence('abcba'))
  end

  def test_ex2
    assert_equal(true, reverseexistence('racecar'))
  end

  def test_ex3
    assert_equal(false, reverseexistence('abcd'))
  end

  def test_ex4
    assert_equal(true, reverseexistence('banana'))
  end

  def test_ex5
    assert_equal(true, reverseexistence('hello'))
  end

end
