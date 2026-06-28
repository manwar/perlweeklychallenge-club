#! /usr/bin/ruby

def reversestring(a)
  if a == ""
    return a
  end
  b = ""
  l = a.size - 1
  aa = a.chars
  0.upto(l) do |i|
    b += aa[l - i]
  end
  b
end

require 'test/unit'

class TestReversestring < Test::Unit::TestCase

  def test_ex1
    assert_equal('', reversestring(''))
  end

  def test_ex2
    assert_equal('gnirts nevig eht esrever', reversestring('reverse the given string'))
  end

end
