#! /usr/bin/ruby

require 'test/unit'

require 'set'

def binaryflip(n)
  m = n
  r = 0
  while (m > 0) do
    m >>= 1
    r += 1
  end
  return (1 << r) - 1 - n
end

class TestBinaryflip < Test::Unit::TestCase

  def test_ex1
    assert_equal(2, binaryflip(5));
  end

  def test_ex2
    assert_equal(3, binaryflip(4));
  end

  def test_ex3
    assert_equal(1, binaryflip(6));
  end
end
