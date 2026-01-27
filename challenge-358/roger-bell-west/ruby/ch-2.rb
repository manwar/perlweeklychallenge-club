#! /usr/bin/ruby

def rotx(a, offset)
  o = offset.modulo(26)
  base = 0
  if a >= 'a' && a <= 'z'
    base = 'a'.ord
  elsif a >= 'A' && a <= 'Z'
    base = 'A'.ord
  else
    return a
  end
  c = (a.ord - base + o).modulo(26) + base
  c.chr
end

def encryptedstring(a, offset)
  a.chars.map {|x| rotx(x, offset)}.join("")
end

require 'test/unit'

class TestEncryptedstring < Test::Unit::TestCase

  def test_ex1
    assert_equal('bcd', encryptedstring('abc', 1))
  end

  def test_ex2
    assert_equal('zab', encryptedstring('xyz', 2))
  end

  def test_ex3
    assert_equal('bcd', encryptedstring('abc', 27))
  end

  def test_ex4
    assert_equal('mjqqt', encryptedstring('hello', 5))
  end

  def test_ex5
    assert_equal('perl', encryptedstring('perl', 26))
  end

end
