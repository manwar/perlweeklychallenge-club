#! /usr/bin/python3

def brokenkeys(a, k):
  out = 0
  failset = set(c.lower() for c in k)
  for word in a.lower().split(" "):
    wordset = set(word)
    if len(failset.intersection(wordset)) == 0:
      out += 1
  return out

import unittest

class TestBrokenkeys(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(brokenkeys("Perl Weekly Challenge", ["l", "a"]), 0, 'example 1')

  def test_ex2(self):
    self.assertEqual(brokenkeys("Perl and Raku", ["a"]), 1, 'example 2')

  def test_ex3(self):
    self.assertEqual(brokenkeys("Well done Team PWC", ["l", "o"]), 2, 'example 3')

unittest.main()
