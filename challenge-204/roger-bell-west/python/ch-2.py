#! /usr/bin/python3

import unittest

def reshapematrix(m, r, c):
  mv = [ i for o in m for i in o ]
  if r * c != len(mv):
    return [[0]]
  out = []
  for i in range(0, r):
    out.append(mv[i * c : (i + 1) * c])
  return out

class TestReshapematrix(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(reshapematrix([[1, 2], [3, 4]], 1, 4), [[1, 2, 3, 4]], 'example 1')

  def test_ex2(self):
    self.assertEqual(reshapematrix([[1, 2, 3], [4, 5, 6]], 3, 2), [[1, 2], [3, 4], [5, 6]], 'example 2')

  def test_ex3(self):
    self.assertEqual(reshapematrix([[1, 2]], 3, 2), [[0]], 'example 3')

unittest.main()
