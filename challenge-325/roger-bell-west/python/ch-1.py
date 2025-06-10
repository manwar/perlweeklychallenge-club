#! /usr/bin/python3

def consecutiveone(a):
  h = dict()
  h[0] = 0
  latch = 0
  latched = False
  for i, n in enumerate(a):
    if n == 1 and not latched:
      latched = True
      latch = i
    if n == 0 and latched:
      latched = False
      h[latch] = i - latch
  if latched:
    h[latch] = len(a) - latch
  return max(h.values())

import unittest

class TestConsecutiveone(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(consecutiveone([0, 1, 1, 0, 1, 1, 1]), 3, 'example 1')

  def test_ex2(self):
    self.assertEqual(consecutiveone([0, 0, 0, 0]), 0, 'example 2')

  def test_ex3(self):
    self.assertEqual(consecutiveone([1, 0, 1, 0, 1, 1]), 2, 'example 3')

unittest.main()
