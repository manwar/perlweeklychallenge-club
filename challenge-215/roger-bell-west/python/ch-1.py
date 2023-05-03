#! /usr/bin/python3

def oddoneout(a):
  ct = 0
  for s in a:
    p = [i for i in s]
    p.sort()
    if ''.join(p) != s:
      ct += 1
  return ct

import unittest

class TestOddoneout(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(oddoneout(["abc", "xyz", "tsu"]), 1, 'example 1')

  def test_ex2(self):
    self.assertEqual(oddoneout(["rat", "cab", "dad"]), 3, 'example 2')

  def test_ex3(self):
    self.assertEqual(oddoneout(["x", "y", "z"]), 0, 'example 3')

unittest.main()
