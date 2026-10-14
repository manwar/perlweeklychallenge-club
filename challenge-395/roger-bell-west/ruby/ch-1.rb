#! /usr/bin/ruby

def parsecomplex(a)
  re = Regexp.new('^\(?([-0-9]+)\)?\+\(?([-0-9]+)\)?i$')
  md = re.match(a)
  if md.nil?
    [0, 0]
  else
    c = []
    1.upto(2) do |n|
      c.push(md[n].to_i)
    end
    c
  end
end

def complexnumber(aa, bb)
  (a, b) = parsecomplex(aa)
  (c, d) = parsecomplex(bb)
  ca =  a * c - b * d
  cb = a * d + b * c
  if cb >= 0
    ca.to_s + "+" + cb.to_s + "i"
  else
    ca.to_s + "+(" + cb.to_s + ")i"
  end
end

require 'test/unit'

class TestComplexnumber < Test::Unit::TestCase

  def test_ex1
    assert_equal('0+2i', complexnumber('1+1i', '1+1i'))
  end

  def test_ex2
    assert_equal('0+(-2)i', complexnumber('1+(-1)i', '1+(-1)i'))
  end

  def test_ex3
    assert_equal('-12+0i', complexnumber('0+3i', '0+4i'))
  end

  def test_ex4
    assert_equal('25+0i', complexnumber('3+4i', '3+(-4)i'))
  end

  def test_ex5
    assert_equal('100+1700i', complexnumber('50+-20i', '-10+30i'))
  end

end
