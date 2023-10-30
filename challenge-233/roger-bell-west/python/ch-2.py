#! /usr/bin/python3

from collections import defaultdict

def frequencysort(a):
  ct = defaultdict(lambda: 0)
  for x in a:
    ct[x] += 1
  rct = defaultdict(lambda: [])
  for k, v in ct.items():
    rct[v].append(k)
  out = []
  for k in sorted(rct):
    for v in reversed(sorted(rct[k])):
      for i in range(k):
        out.append(v)
  return out
    
    
import unittest

class TestFrequencysort(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(frequencysort([1, 1, 2, 2, 2, 3]), [3, 1, 1, 2, 2, 2], 'example 1')

  def test_ex2(self):
    self.assertEqual(frequencysort([2, 3, 1, 3, 2]), [1, 3, 3, 2, 2], 'example 2')

  def test_ex3(self):
    self.assertEqual(frequencysort([-1, 1, -6, 4, 5, -6, 1, 4, 1]), [5, -1, 4, 4, -6, -6, 1, 1, 1], 'example 3')

unittest.main()
