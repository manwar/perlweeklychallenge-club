#! /usr/bin/python3

def lexicographic(a):
  t = 0
  for st in a:
    q = list(st)
    q.sort()
    if "".join(q) == st:
      continue
    q.reverse()
    if "".join(q) == st:
      continue
    t += 1
  return t

import unittest

class TestLexicographic(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(lexicographic(["abc", "bce", "cae"]), 1, 'example 1')

  def test_ex2(self):
    self.assertEqual(lexicographic(["yxz", "cba", "mon"]), 2, 'example 2')

unittest.main()
