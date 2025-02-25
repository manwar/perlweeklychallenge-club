#! /usr/bin/python3

def arraysintersection(a):
  s = set(a[0])
  for bi in range(1, len(a)):
    s = s.intersection(set(a[bi]))
  o = list(s)
  o.sort()
  return o

import unittest

class TestArraysintersection(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(arraysintersection([[1, 2, 3, 4], [4, 5, 6, 1], [4, 2, 1, 3]]), [1, 4], 'example 1')

  def test_ex2(self):
    self.assertEqual(arraysintersection([[1, 0, 2, 3], [2, 4, 5]]), [2], 'example 2')

  def test_ex3(self):
    self.assertEqual(arraysintersection([[1, 2, 3], [4, 5], [6]]), [], 'example 3')

unittest.main()
