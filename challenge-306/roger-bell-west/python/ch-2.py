#! /usr/bin/python3

def lastelement(a):
  b = a
  while True:
    b.sort()
    f = b.pop()
    s = b.pop()
    if f > s:
      b.append(f - s)
    if len(b) == 0:
      return 0
    if len(b) == 1:
      return b[0]

import unittest

class TestLastelement(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(lastelement([3, 8, 5, 2, 9, 2]), 1, 'example 1')

  def test_ex2(self):
    self.assertEqual(lastelement([3, 2, 5]), 0, 'example 2')

unittest.main()
