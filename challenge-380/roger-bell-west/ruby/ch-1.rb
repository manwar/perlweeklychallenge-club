#! /usr/bin/ruby

def counterify(a)
  cc = Hash.new
  cc.default = 0
  a.each do |x|
    cc[x] += 1
  end
  return cc
end

def sumoffrequencies(a)
  vw = 0
  cn = 0
  cc = counterify(a.chars)
  cv = cc.values.sort.reverse
  cv.each do |n|
    cc.select { |c, ni| ni == n }.each do |c, _|
      case c
      when 'a', 'e', 'i', 'o', 'u'
        if vw == 0
          vw = n
        end
      else
        if cn == 0
          cn = n
        end
      end
    end
    if vw > 0 && cn > 0
      break
    end
  end
  vw + cn
end

require 'test/unit'

class TestSumoffrequencies < Test::Unit::TestCase

  def test_ex1
    assert_equal(5, sumoffrequencies('banana'))
  end

  def test_ex2
    assert_equal(7, sumoffrequencies('teestett'))
  end

  def test_ex3
    assert_equal(3, sumoffrequencies('aeiouuaa'))
  end

  def test_ex4
    assert_equal(2, sumoffrequencies('rhythm'))
  end

  def test_ex5
    assert_equal(1, sumoffrequencies('x'))
  end

end
