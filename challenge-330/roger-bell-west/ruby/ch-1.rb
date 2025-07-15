#! /usr/bin/ruby

def cleardigits(a)
  out = Array.new
  a.chars.each do |c|
    if c >= '0' && c <= '9'
      out.pop
    else
      out.push(c)
    end
  end
  out.join("")
end

require 'test/unit'

class TestCleardigits < Test::Unit::TestCase

  def test_ex1
    assert_equal('c', cleardigits('cab12'))
  end

  def test_ex2
    assert_equal('', cleardigits('xy99'))
  end

  def test_ex3
    assert_equal('perl', cleardigits('pa1erl'))
  end

end
