#! /usr/bin/python3

import unittest

def pattern132(l):
  o = []
  for a in range(0, len(l) - 2):
    for b in range(a + 1, len(l) - 1):
      if l[a] < l[b]:
        for c in range(b + 1, len(l)):
          if l[b] > l[c] and l[a] < l[c]:
            o = [l[a], l[b], l[c]]
            break
      if len(o) > 0:
        break
    if len(o) > 0:
      break
  return o

class TestPattern132(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(pattern132([3, 1, 4, 2]), [1, 4, 2], 'example 1')

  def test_ex2(self):
    self.assertEqual(pattern132([1, 2, 3, 4]), [], 'example 2')

  def test_ex3(self):
    self.assertEqual(pattern132([1, 3, 2, 4, 6, 5]), [1, 3, 2], 'example 3')

  def test_ex4(self):
    self.assertEqual(pattern132([1, 3, 4, 2]), [1, 3, 2], 'example 4')

unittest.main()
