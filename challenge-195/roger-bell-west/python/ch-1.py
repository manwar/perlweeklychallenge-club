#! /usr/bin/python3

import unittest

def specialintegers(n):
  o = 0
  for i in range(1, n+1):
    s = True
    f = set()
    for c in str(i):
      if c in f:
        s = False
        break
      else:
        f.add(c)
    if s:
      o += 1
  return o

class TestSpecialIntegers(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(specialintegers(15), 14, 'example 1')

  def test_ex2(self):
    self.assertEqual(specialintegers(35), 32, 'example 2')

unittest.main()
