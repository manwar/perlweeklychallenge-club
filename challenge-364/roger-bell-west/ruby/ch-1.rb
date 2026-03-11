#! /usr/bin/ruby

def decryptstring(a)
  out = ""
  c = a.chars
  s = 0
  while s < c.size
    m = c[s].to_i
    if s + 2 < c.size && c[s + 2] == '#'
      m = m * 10 + c[s + 1].to_i
      s += 2
    end
    s += 1
    out += (96 + m).chr
  end
  out
end

require 'test/unit'

class TestDecryptstring < Test::Unit::TestCase

  def test_ex1
    assert_equal('jkab', decryptstring('10#11#12'))
  end

  def test_ex2
    assert_equal('acz', decryptstring('1326#'))
  end

  def test_ex3
    assert_equal('yxabc', decryptstring('25#24#123'))
  end

  def test_ex4
    assert_equal('te', decryptstring('20#5'))
  end

  def test_ex5
    assert_equal('aijz', decryptstring('1910#26#'))
  end

end
