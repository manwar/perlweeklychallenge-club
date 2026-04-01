#! /usr/bin/ruby

def maxoddbinary(a)
  ones = 0
  zeroes = 0
  a.chars.each do |c|
    case c
    when '0'
      zeroes += 1
    when '1'
      ones += 1
    end
  end
  if ones < 1
    return ""
  end
  out = ""
  out += "1" * (ones - 1)
  out += "0" * (zeroes)
  out += '1'
  out
end

require 'test/unit'

class TestMaxoddbinary < Test::Unit::TestCase

  def test_ex1
    assert_equal('1101', maxoddbinary('1011'))
  end

  def test_ex2
    assert_equal('001', maxoddbinary('100'))
  end

  def test_ex3
    assert_equal('110001', maxoddbinary('111000'))
  end

  def test_ex4
    assert_equal('1001', maxoddbinary('0101'))
  end

  def test_ex5
    assert_equal('1111', maxoddbinary('1111'))
  end

end
