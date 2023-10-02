#! /usr/bin/python3

def shufflestring(st, mp):
  r = list(" " for i in range(len(st)))
  for i, ix in enumerate(mp):
    r[ix] = st[i]
  return "".join(r)

import unittest

class TestShufflestring(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(shufflestring("lacelengh", [3, 2, 0, 5, 4, 8, 6, 7, 1]), "challenge", 'example 1')

  def test_ex2(self):
    self.assertEqual(shufflestring("rulepark", [4, 7, 3, 1, 0, 5, 2, 6]), "perlraku", 'example 2')

unittest.main()
