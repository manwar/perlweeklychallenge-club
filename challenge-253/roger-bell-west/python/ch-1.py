#! /usr/bin/python3

def splitstrings(a, sep):
  p = []
  for s in a:
    for n in s.split(sep):
      if len(n) > 0:
        p.append(n)
  return p

import unittest

class TestSplitstrings(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(splitstrings(["one.two.three", "four.five", "six"], "."), ["one", "two", "three", "four", "five", "six"], 'example 1')

  def test_ex2(self):
    self.assertEqual(splitstrings(["$perl$$", "$$raku$"], "$"), ["perl", "raku"], 'example 2')

unittest.main()
