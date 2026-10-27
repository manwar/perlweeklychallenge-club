#!/usr/local/env ruby

require "minitest/autorun"

def reflect(n)
  (n & 0xFFFFFFFFFFFFFFFF).to_s(2).reverse.to_i(2)
end

def binary_reflection(xs)
  xs.sort_by {|e| [reflect(e),e]}
end

class TestBinaryReflection < Minitest::Test
  def test_example1
    assert_equal [3,6,12],binary_reflection([3,6,12])
  end

  def test_example2
    assert_equal [1,2,4,8],binary_reflection([1,2,4,8])
  end

  def test_example3
    assert_equal [8,10,7,9],binary_reflection([7,8,9,10])
  end

  def test_example4
    assert_equal [5,9,15,17],binary_reflection([5,9,15,17])
  end

  def test_example5
    assert_equal [14,13,11,19],binary_reflection([11,13,14,19])
  end
end

