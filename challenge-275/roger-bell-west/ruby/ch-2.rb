#! /usr/bin/ruby

def replacedigits(a)
  out = ""
  prev = 0
  a.chars.each do |c|
    out += case c
           when '0'..'9'
             (prev + c.to_i).chr
           else
             prev = c.ord
             c
           end
  end
  out
end

require 'test/unit'

class TestReplacedigits < Test::Unit::TestCase

  def test_ex1
    assert_equal('abcdef', replacedigits('a1c1e1'))
  end

  def test_ex2
    assert_equal('abbdcfdh', replacedigits('a1b2c3d4'))
  end

  def test_ex3
    assert_equal('bdb', replacedigits('b2b'))
  end

  def test_ex4
    assert_equal('abgz', replacedigits('a16z'))
  end

end
