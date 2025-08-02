#! /usr/bin/ruby

def stringscore(a)
  out = 0
  a.chars.each_cons(2) do |c|
    out += (c[0].ord() - c[1].ord()).abs
  end
  out
end

require 'test/unit'

class TestStringscore < Test::Unit::TestCase

  def test_ex1
    assert_equal(13, stringscore('hello'))
  end

  def test_ex2
    assert_equal(30, stringscore('perl'))
  end

  def test_ex3
    assert_equal(37, stringscore('raku'))
  end

end
