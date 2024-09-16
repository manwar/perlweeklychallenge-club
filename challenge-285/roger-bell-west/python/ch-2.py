#! /usr/bin/python3

from itertools import product
from math import floor

def makingchange(a):
  coins = [1, 5, 10, 25, 50]
  mx = [floor(a / x) for x in coins]
  pat = []
  for i in range(len(coins)):
    if mx[i] > 0:
      pat.append([x for x in range(mx[i] + 1)])
    else:
      break
  ct = 0
  for combo in product(*pat):
    t = 0
    for i, c in enumerate(combo):
      t += c * coins[i]
      if t > a:
        break
    if t == a:
      ct += 1
  return ct

import unittest

class TestMakingchange(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(makingchange(9), 2, 'example 1')

  def test_ex2(self):
    self.assertEqual(makingchange(15), 6, 'example 2')

  def test_ex3(self):
    self.assertEqual(makingchange(100), 292, 'example 3')

unittest.main()
