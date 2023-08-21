#! /usr/bin/python3

def separatedigits(a):
  out = []
  for n in a:
    m = n
    v = []
    while m > 0:
      v.append(m % 10)
      m //= 10
    v.reverse()
    out.extend(v)
  return out

import unittest

class TestSeparatedigits(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(separatedigits([1, 34, 5, 6]), [1, 3, 4, 5, 6], 'example 1')

  def test_ex2(self):
    self.assertEqual(separatedigits([1, 24, 51, 60]), [1, 2, 4, 5, 1, 6, 0], 'example 2')

unittest.main()
