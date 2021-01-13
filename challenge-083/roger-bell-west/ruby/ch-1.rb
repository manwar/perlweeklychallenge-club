#! /usr/bin/ruby

def wl(s)
  a=s.split(' ')
  return a[1...-1].join('').length
end

require 'test/unit'

class TestWl < Test::Unit::TestCase

  def test_ex1
    assert_equal(6,wl('The Weekly Challenge'))
  end

  def test_ex2
    assert_equal(23,wl('The purpose of our lives is to be happy'))
  end

end
