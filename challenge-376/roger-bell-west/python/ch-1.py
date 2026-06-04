#! /usr/bin/python3

def cs2xy(a):
  x = ord(a[0]) - ord('a')
  y = ord(a[1]) - ord('1')
  return [x, y]

def checkcolor(a):
  xy = cs2xy(a)
  return (xy[0] + xy[1]) % 2 == 1

def chessboardsquares(a, b):
  return checkcolor(a) == checkcolor(b)

import unittest

class TestChessboardsquares(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(chessboardsquares("a7", "f4"), True, 'example 1')

  def test_ex2(self):
    self.assertEqual(chessboardsquares("c1", "e8"), False, 'example 2')

  def test_ex3(self):
    self.assertEqual(chessboardsquares("b5", "h2"), False, 'example 3')

  def test_ex4(self):
    self.assertEqual(chessboardsquares("f3", "h1"), True, 'example 4')

  def test_ex5(self):
    self.assertEqual(chessboardsquares("a1", "g8"), False, 'example 5')

unittest.main()
