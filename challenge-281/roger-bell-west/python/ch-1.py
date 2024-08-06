#! /usr/bin/python3

def cs2xy(a):
  x = ord(a[0]) - ord('a')
  y = ord(a[1]) - ord('1')
  return [x, y]

def checkcolor(a):
  xy = cs2xy(a)
  return (xy[0] + xy[1]) % 2 == 1

import unittest

class TestCheckcolor(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(checkcolor("d3"), True, 'example 1')

  def test_ex2(self):
    self.assertEqual(checkcolor("g5"), False, 'example 2')

  def test_ex3(self):
    self.assertEqual(checkcolor("e6"), True, 'example 3')

unittest.main()
