#! /usr/bin/ruby

def cs2xy(a)
  c = a.chars
  x = c[0].ord - 'a'.ord
  y = c[1].ord - '1'.ord
  [x, y]
end

def checkcolor(a)
  xy = cs2xy(a)
  (xy[0] + xy[1]) % 2 == 1
end

require 'test/unit'

class TestCheckcolor < Test::Unit::TestCase

  def test_ex1
    assert_equal(true, checkcolor('d3'))
  end

  def test_ex2
    assert_equal(false, checkcolor('g5'))
  end

  def test_ex3
    assert_equal(true, checkcolor('e6'))
  end

end
