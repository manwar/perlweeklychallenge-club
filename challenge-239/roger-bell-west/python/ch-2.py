#! /usr/bin/python3

def consistentstrings(a, v):
  vs = set(v)
  return len([s for s in a if all(c in vs for c in set(s))])

import unittest

class TestConsistentstrings(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(consistentstrings(["ad", "bd", "aaab", "baa", "badab"], "ab"), 2, 'example 1')

  def test_ex2(self):
    self.assertEqual(consistentstrings(["a", "b", "c", "ab", "ac", "bc", "abc"], "ab"), 3, 'example 2')

  def test_ex3(self):
    self.assertEqual(consistentstrings(["cc", "acd", "b", "ba", "bac", "bad", "ac", "d"], "cad"), 4, 'example 3')

unittest.main()
