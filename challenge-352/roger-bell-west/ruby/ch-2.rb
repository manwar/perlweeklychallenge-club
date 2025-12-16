#! /usr/bin/ruby

def binaryprefix(a)
  c = 0
  out = []
  a.each do |n|
    c *= 2
    c += n
    out.push(c % 5 == 0)
  end
  out
end

require 'test/unit'

class TestBinaryprefix < Test::Unit::TestCase

  def test_ex1
    assert_equal([true, false, false, false, false, true, true, false, false, false], binaryprefix([0, 1, 1, 0, 0, 1, 0, 1, 1, 1]))
  end

  def test_ex2
    assert_equal([false, false, true, true, false, false], binaryprefix([1, 0, 1, 0, 1, 0]))
  end

  def test_ex3
    assert_equal([true, true, false, false, true], binaryprefix([0, 0, 1, 0, 1]))
  end

  def test_ex4
    assert_equal([false, false, false, true, false], binaryprefix([1, 1, 1, 1, 1]))
  end

  def test_ex5
    assert_equal([false, false, true, false, false, true, true, true, false, false], binaryprefix([1, 0, 1, 1, 0, 1, 0, 0, 1, 1]))
  end

end
