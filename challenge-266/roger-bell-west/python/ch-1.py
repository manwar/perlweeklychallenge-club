#! /usr/bin/python3

from collections import defaultdict

def getlistset(a):
  la = a.split(" ")
  ca = defaultdict(lambda: 0)
  for w in la:
    ca[w] += 1
  lb = [w for w in la if ca[w] == 1]
  return lb, set(ca.keys())

def uncommonwords(a, b):
  la, sa = getlistset(a)
  lb, sb = getlistset(b)
  out = []
  for wl, t in ((la, sb), (lb, sa)):
    for w in wl:
      if w not in t:
        out.append(w)
  return out

import unittest

class TestUncommonwords(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(uncommonwords("Mango is sweet", "Mango is sour"), ["sweet", "sour"], 'example 1')

  def test_ex2(self):
    self.assertEqual(uncommonwords("Mango Mango", "Orange"), ["Orange"], 'example 2')

  def test_ex3(self):
    self.assertEqual(uncommonwords("Mango is Mango", "Orange is Orange"), [], 'example 3')

unittest.main()
