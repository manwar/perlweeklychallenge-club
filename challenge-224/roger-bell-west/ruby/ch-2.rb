#! /usr/bin/ruby

def exdigits(digits, st, ed)
  x = 0
  st.upto(ed) do |i|
    x *= 10
    x += digits[i]
  end
  return x
end

def additivenumber(digitstring)
  digits = digitstring.chars.map{|i| i.to_i}
  stack = []
  0.upto(digits.length - 3) do |i|
    (i+1).upto(digits.length - 2) do |j|
      stack.push([0, i, j])
    end
  end
  while stack.length > 0 do
    t = stack.pop
    start_a = t[0]
    end_a = t[1]
    end_b = t[2]
    start_b = end_a + 1
    val_ab = exdigits(digits, start_a, end_a) +
             exdigits(digits, start_b, end_b)
    start_c = end_b + 1
    start_c.upto(digits.length - 1) do |end_c|
      if val_ab == exdigits(digits, start_c, end_c) then
        if end_c == digits.length - 1 then
          return true
        else
          stack.push([start_b, end_b, end_c])
          break
        end
      end
    end
  end
  return false
end

require 'test/unit'

class TestAdditivenumber < Test::Unit::TestCase

  def test_ex1
    assert_equal(true, additivenumber('112358'))
  end

  def test_ex2
    assert_equal(false, additivenumber('12345'))
  end

  def test_ex3
    assert_equal(true, additivenumber('199100199'))
  end

end
