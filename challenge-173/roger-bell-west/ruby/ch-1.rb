#! /usr/bin/ruby

require 'test/unit'

def esthetic(n0, base)
  n = n0
  pdigit = 0
  ch = false
  while n > 0 do
    n,digit = n.divmod(base)
    if ch && (digit-pdigit).abs != 1 then
      return false
    end
    ch = true
    pdigit = digit
  end
  return true
end

def esthetic10(n)
  return esthetic(n, 10)
end

class TestEsthetic < Test::Unit::TestCase

  def test_ex1
    assert_equal(true,esthetic10(5456))
  end

  def test_ex2
    assert_equal(false,esthetic10(120))
  end

  def test_ex3
    assert_equal(true,esthetic10(12))
  end

  def test_ex4
    assert_equal(true,esthetic10(5654))
  end

  def test_ex5
    assert_equal(false,esthetic10(890))
  end

end
