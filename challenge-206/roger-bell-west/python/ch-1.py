#! /usr/bin/python3

import unittest

from datetime import time
from itertools import combinations

def shortesttime(n):
  dl = 1440
  ni = []
  for x in n:
    t = time.fromisoformat(x + ":00")
    ni.append(t.hour * 60 + t.minute)
  o = []
  for p in combinations(ni, 2):
    d = abs(p[0] - p[1])
    o.append(d)
    o.append(dl - d)
  return min(o)

class TestShortesttime(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(shortesttime(["00:00", "23:55", "20:00"]), 5, 'example 1')

  def test_ex2(self):
    self.assertEqual(shortesttime(["01:01", "00:50", "00:57"]), 4, 'example 2')

  def test_ex3(self):
    self.assertEqual(shortesttime(["10:10", "09:30", "09:00", "09:55"]), 15, 'example 3')

unittest.main()
