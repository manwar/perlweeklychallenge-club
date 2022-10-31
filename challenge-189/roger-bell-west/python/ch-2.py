#! /usr/bin/python3

import unittest

from collections import defaultdict

def arraydegree(a):
  f = defaultdict(lambda: 0)
  for x in a:
    f[x] += 1
  degree = max(f.values())
  inverse = defaultdict(list)
  for (i, x) in enumerate(a):
    inverse[x].append(i)
  minlen = 1 + len(a)
  se = [0, 1]
  for n in f.keys():
    if f[n] == degree:
      ll = 1 + inverse[n][-1] - inverse[n][0]
      if ll < minlen:
        minlen = ll
        se = [inverse[n][0], inverse[n][-1]]
  return a[se[0] : se[1]+1]

class TestArraydegree(unittest.TestCase):
            
  def test_ex1(self):
    self.assertEqual(arraydegree([1, 3, 3, 2]), [3, 3], 'example 1')

  def test_ex2(self):
    self.assertEqual(arraydegree([1, 2, 1, 3]), [1, 2, 1], 'example 2')

  def test_ex3(self):
    self.assertEqual(arraydegree([1, 3, 2, 1, 2]), [2, 1, 2], 'example 3')

  def test_ex4(self):
    self.assertEqual(arraydegree([1, 1, 2, 3, 2]), [1, 1], 'example 4')

  def test_ex5(self):
    self.assertEqual(arraydegree([2, 1, 2, 1, 1]), [1, 2, 1, 1], 'example 5')

unittest.main()
