#! /usr/bin/python3

def sortlanguage(langs, popularities):
  ix = list(range(len(langs)))
  ix.sort(key = lambda n: popularities[n])
  return [langs[n] for n in ix]

import unittest

class TestSortlanguage(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(sortlanguage(["perl", "c", "python"], [2, 1, 3]), ["c", "perl", "python"], 'example 1')

  def test_ex2(self):
    self.assertEqual(sortlanguage(["c++", "haskell", "java"], [1, 3, 2]), ["c++", "java", "haskell"], 'example 2')

unittest.main()
