#! /usr/bin/python3

import unittest

def totalzero(aa, bb):
  if aa == 0 and bb == 0:
    return 0
  a = aa
  b = bb
  ct = 1
  while True:
    if a == b:
      return ct
    ct += 1
    if a > b:
      a -= b
    else:
      b -= a

class TestTotalzero(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(totalzero(5, 4), 5, 'example 1')

  def test_ex2(self):
    self.assertEqual(totalzero(4, 6), 3, 'example 2')

  def test_ex3(self):
    self.assertEqual(totalzero(2, 5), 4, 'example 3')

  def test_ex4(self):
    self.assertEqual(totalzero(3, 1), 3, 'example 4')

  def test_ex5(self):
    self.assertEqual(totalzero(7, 4), 5, 'example 5')
            

unittest.main()
