#! /usr/bin/python3

def findwords(a, b):
  out = []
  for i, x in enumerate(a):
    if b in x:
      out.append(i)
  return out

import unittest

class TestFindwords(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(findwords(["the", "weekly", "challenge"], "e"), [0, 1, 2], 'example 1')

  def test_ex2(self):
    self.assertEqual(findwords(["perl", "raku", "python"], "p"), [0, 2], 'example 2')

  def test_ex3(self):
    self.assertEqual(findwords(["abc", "def", "bbb", "bcd"], "b"), [0, 2, 3], 'example 3')

unittest.main()
