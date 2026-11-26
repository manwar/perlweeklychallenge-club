#! /usr/bin/ruby

def fractionaladditionsubstraction(a)
  terms = []
  state = 0
  n = 0
  num = 0
  sign = 0
  cv = a.chars
  i = 0
  while i < cv.length
    case state
    when 0
      case cv[i]
      when '+'
        state = 0
        i += 1
      when '0' .. '9'
        sign = 1
        state = 1
        n = cv[i].to_i
        i += 1
      when '-'
        sign = -1
        state = 1
        n = 0
        i += 1
      end
    when 1
      case cv[i]
      when '0' .. '9'
        n = n * 10 + cv[i].to_i
        i += 1
      when '/'
        num = n * sign
        n = 0
        state = 2
        i += 1
      end
    when 2
      case cv[i]
      when '0' .. '9'
        n = n * 10 + cv[i].to_i
        i += 1
      else
        terms.push(Rational(num, n))
        state = 0
      end
    end
  end
  if state == 2
    terms.push(Rational(num, n))
  end
  out = terms[0]
  1.upto(terms.length - 1) do |nti|
    out = out + terms[nti]
  end
  out.numerator.to_s + "/" + out.denominator.to_s
end

require 'test/unit'

class TestFractionaladditionsubstraction < Test::Unit::TestCase

  def test_ex1
    assert_equal('2/1', fractionaladditionsubstraction('1/2+3/2'))
  end

  def test_ex2
    assert_equal('-4/1', fractionaladditionsubstraction('-5/2-3/2'))
  end

  def test_ex3
    assert_equal('0/1', fractionaladditionsubstraction('5/3-5/3'))
  end

  def test_ex4
    assert_equal('13/10', fractionaladditionsubstraction('10/10-1/10+2/5'))
  end

  def test_ex5
    assert_equal('1/2', fractionaladditionsubstraction('1/6+1/6+1/6'))
  end

end
