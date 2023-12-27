#! /usr/bin/python3

def shortestdistance(a0):
  if len(a0) % 2 != 0:
    return []
  a = a0
  a.sort()
  out = []
  for i in range(0, len(a), 2):
    if a[i] != a[i+1]:
      return []
    out.append([a[i], a[i]])
  return out

import unittest

class TestShortestdistance(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(shortestdistance([3, 2, 3, 2, 2, 2]), [[2, 2], [2, 2], [3, 3]], 'example 1')

  def test_ex2(self):
    self.assertEqual(shortestdistance([1, 2, 3, 4]), [], 'example 2')

unittest.main()
