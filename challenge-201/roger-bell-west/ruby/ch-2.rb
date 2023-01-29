#! /usr/bin/ruby

require 'test/unit'

def pennypiles(n)
  if n == 0 then
    return 1
  end
  s = 0
  j = n - 1
  k = 2
  while j >= 0 do
    t = pennypiles(j)
    if k.div(2) % 2 == 1 then
      s += t
    else
      s -= t
    end
    if k % 2 == 1 then
      j -= k
    else
      j -= k.div(2)
    end
    k += 1
  end
  return s
end

class TestPennypiles < Test::Unit::TestCase

  def test_ex1
    assert_equal(7, pennypiles(5))
  end

  def test_ex2
    assert_equal(42, pennypiles(10))
  end

end
