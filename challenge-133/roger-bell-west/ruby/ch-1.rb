#! /usr/bin/ruby

def isqrt(n)
  k = n >> 1
  x = true
  while x do
    k1=(k+(n/k).to_int) >> 1
    if k1 >= k then
      x=false
    end
    k=k1
  end
  return k
end

require 'test/unit'

class TestIsqrt < Test::Unit::TestCase

  def test_ex1
    assert_equal(3,isqrt(10))
  end

  def test_ex2
    assert_equal(5,isqrt(27))
  end

  def test_ex3
    assert_equal(9,isqrt(85))
  end

  def test_ex4
    assert_equal(10,isqrt(101))
  end

end
