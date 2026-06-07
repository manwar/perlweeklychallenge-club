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

def chessboardsquares(a, b)
  checkcolor(a) == checkcolor(b)
end

require 'test/unit'

class TestChessboardsquares < Test::Unit::TestCase

  def test_ex1
    assert_equal(true, chessboardsquares('a7', 'f4'))
  end

  def test_ex2
    assert_equal(false, chessboardsquares('c1', 'e8'))
  end

  def test_ex3
    assert_equal(false, chessboardsquares('b5', 'h2'))
  end

  def test_ex4
    assert_equal(true, chessboardsquares('f3', 'h1'))
  end

  def test_ex5
    assert_equal(false, chessboardsquares('a1', 'g8'))
  end

end
