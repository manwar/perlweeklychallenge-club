#! /usr/bin/ruby

require 'prime'

def binaryprefix(a)
  out = []
  n = 0
  a.each do |x|
    n *= 2
    if x == 1
      n += 1
    end
    out.push(n.prime?)
  end
  out
end

require 'test/unit'

class TestBinaryprefix < Test::Unit::TestCase

  def test_ex1
    assert_equal([false, true, true], binaryprefix([1, 0, 1]))
  end

  def test_ex2
    assert_equal([false, true, false], binaryprefix([1, 1, 0]))
  end

  def test_ex3
    assert_equal([false, true, true, false, false, true, false, false, false, false, false, false, false, false, false, false, false, false, false, true], binaryprefix([1, 1, 1, 1, 0, 1, 0, 0, 0, 0, 1, 0, 1, 0, 0, 1, 0, 0, 0, 1]))
  end

end
