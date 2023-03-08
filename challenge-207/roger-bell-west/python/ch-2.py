#! /usr/bin/python3

def h_index(c0):
  c = c0
  c.sort()
  c.reverse()
  h = 0
  for i, x in enumerate(c):
    if i + 1 <= x:
      h = i + 1
    else:
      break
  return h

import unittest

class TestH_index(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(h_index([10, 8, 5, 4, 3]), 4, 'example 1')

  def test_ex2(self):
    self.assertEqual(h_index([25, 8, 5, 3, 3]), 3, 'example 2')

unittest.main()
