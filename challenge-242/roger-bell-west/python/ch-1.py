#! /usr/bin/python3

def unique(a):
  ss = set()
  b = []
  for i in a:
    if i not in ss:
      b.append(i)
      ss.add(i)
  return b

def halfmissing(a, bh):
  return unique(i for i in a if i not in bh)

def missingmembers(a, b):
  ah = set(a)
  bh = set(b)
  return [halfmissing(a, bh), halfmissing(b, ah)]

import unittest

class TestMissingmembers(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(missingmembers([1, 2, 3], [2, 4, 6]), [[1, 3], [4, 6]], 'example 1')

  def test_ex2(self):
    self.assertEqual(missingmembers([1, 2, 3, 3], [1, 1, 2, 2]), [[3], []], 'example 2')

unittest.main()
