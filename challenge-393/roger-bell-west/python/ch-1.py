#! /usr/bin/python3

from functools import lru_cache

@lru_cache(maxsize=None)
def squared(x):
  return x * x
    
def pythagorasmultiplied(n):
  ct = 0
  for c in range(5, n + 1):
    csquared = squared(c)
    for a in range(1, c - 1):
      asquared = squared(a)
      for b in range(a + 1, c):
        bsquared = squared(b)
        tot = asquared + bsquared
        if tot > csquared:
          break
        if tot == csquared:
          ct += 1
  return ct * 2

import unittest

class TestPythagorasmultiplied(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(pythagorasmultiplied(20), 12, 'example 1')

  def test_ex2(self):
    self.assertEqual(pythagorasmultiplied(7), 2, 'example 2')

  def test_ex3(self):
    self.assertEqual(pythagorasmultiplied(1), 0, 'example 3')

  def test_ex4(self):
    self.assertEqual(pythagorasmultiplied(15), 8, 'example 4')

  def test_ex5(self):
    self.assertEqual(pythagorasmultiplied(30), 22, 'example 5')

unittest.main()
