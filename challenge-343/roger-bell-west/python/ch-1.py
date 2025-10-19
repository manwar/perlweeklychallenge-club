#! /usr/bin/python3

def zerofriend(a):
  b = min(abs(x) for x in a)
  if b in a:
    return b
  return -b

import unittest

class TestZerofriend(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(zerofriend([4, 2, -1, 3, -2]), -1, 'example 1')

  def test_ex2(self):
    self.assertEqual(zerofriend([-5, 5, -3, 3, -1, 1]), 1, 'example 2')

  def test_ex3(self):
    self.assertEqual(zerofriend([7, -3, 0, 2, -8]), 0, 'example 3')

  def test_ex4(self):
    self.assertEqual(zerofriend([-2, -5, -1, -8]), -1, 'example 4')

  def test_ex5(self):
    self.assertEqual(zerofriend([-2, 2, -4, 4, -1, 1]), 1, 'example 5')

unittest.main()
