#! /usr/bin/python3

from itertools import permutations

def dictionaryrank(a):
  d = set()
  for o in permutations(a):
    d.add("".join(o))
  dd = list(d)
  dd.sort()
  for i, s in enumerate(dd):
    if s == a:
      return i + 1
  return 0

import unittest

class TestDictionaryrank(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(dictionaryrank("CAT"), 3, 'example 1')

  def test_ex2(self):
    self.assertEqual(dictionaryrank("GOOGLE"), 88, 'example 2')

  def test_ex3(self):
    self.assertEqual(dictionaryrank("SECRET"), 255, 'example 3')

unittest.main()
