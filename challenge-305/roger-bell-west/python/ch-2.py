#! /usr/bin/python3

def aliendictionary(a, dc):
  mxl = max(len(x) for x in a)
  dh = dict()
  for i, c in enumerate(dc):
    dh[c] = i + 1
  b = a
  numerics = dict()
  for w in a:
    n = 0
    for i in range(mxl):
      n *= 27
      if i < len(w):
        n += dh[w[i]]
    numerics[w] = n
  b.sort(key = lambda i: numerics[i])
  return b

import unittest

class TestAliendictionary(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(aliendictionary(["perl", "python", "raku"], ["h", "l", "a", "b", "y", "d", "e", "f", "g", "i", "r", "k", "m", "n", "o", "p", "q", "j", "s", "t", "u", "v", "w", "x", "c", "z"]), ["raku", "python", "perl"], 'example 1')

  def test_ex2(self):
    self.assertEqual(aliendictionary(["the", "weekly", "challenge"], ["c", "o", "r", "l", "d", "a", "b", "t", "e", "f", "g", "h", "i", "j", "k", "m", "n", "p", "q", "s", "w", "u", "v", "x", "y", "z"]), ["challenge", "the", "weekly"], 'example 2')

unittest.main()
