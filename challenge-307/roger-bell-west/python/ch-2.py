#! /usr/bin/python3

def findanagrams(a):
  b = ["".join(sorted(s)) for s in a]
  out = 1
  for i in range(1, len(b)):
    if b[i - 1] != b[i]:
      out += 1
  return out

import unittest

class TestFindanagrams(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(findanagrams(["acca", "dog", "god", "perl", "repl"]), 3, 'example 1')

  def test_ex2(self):
    self.assertEqual(findanagrams(["abba", "baba", "aabb", "ab", "ab"]), 2, 'example 2')

unittest.main()
