#! /usr/bin/python3

def distringmatch(a):
  v = 1 << (len(a) - 1)
  wv = v << 1
  out = [wv]
  for c in a:
    if c == "I":
      wv += v
    else:
      wv -= v
    v >>= 1
    out.append(wv)
  c = dict()
  q = out.copy()
  q.sort()
  for i, v in enumerate(q):
    c[v] = i
  return [c[v] for v in out]
      

import unittest

class TestDistringmatch(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(distringmatch("IDID"), [0, 4, 1, 3, 2], 'example 1')

  def test_ex2(self):
    self.assertEqual(distringmatch("III"), [0, 1, 2, 3], 'example 2')

  def test_ex3(self):
    self.assertEqual(distringmatch("DDI"), [3, 2, 0, 1], 'example 3')

unittest.main()
