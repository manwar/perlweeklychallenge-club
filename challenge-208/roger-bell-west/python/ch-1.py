#! /usr/bin/python3

import unittest

def v2hm(a):
  h = dict()
  for i, x in enumerate(a):
    if x not in h:
      h[x] = i
  return h

def minindexsum(a, b):
  ah = v2hm(a)
  bh = v2hm(b)
  out = []
  mi = len(a) + len(b)
  for w in a:
    if w in bh:
      mv = ah[w] + bh[w]
      if mv < mi:
        out = []
        mi = mv
      if mv == mi:
        out.append(w)
  return out

class TestMinindexsum(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(minindexsum(["Perl", "Raku", "Love"], ["Raku", "Perl", "Hate"]), ["Perl", "Raku"], 'example 1')

  def test_ex2(self):
    self.assertEqual(minindexsum(["A", "B", "C"], ["D", "E", "F"]), [], 'example 2')

  def test_ex3(self):
    self.assertEqual(minindexsum(["A", "B", "C"], ["C", "A", "B"]), ["A"], 'example 3')

unittest.main()
