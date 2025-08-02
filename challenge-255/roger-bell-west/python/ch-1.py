#! /usr/bin/python3

from collections import defaultdict

def oddcharacter(s, t):
  ss = defaultdict(lambda: 0)
  for c in s:
    ss[c] += 1
  for c in t:
    if c in ss and ss[c] > 0:
      ss[c] -= 1
    else:
      return c
  return "@"

import unittest

class TestOddcharacter(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(oddcharacter("Perl", "Preel"), "e", 'example 1')

  def test_ex2(self):
    self.assertEqual(oddcharacter("Weekly", "Weeakly"), "a", 'example 2')

  def test_ex3(self):
    self.assertEqual(oddcharacter("Box", "Boxy"), "y", 'example 3')

unittest.main()
