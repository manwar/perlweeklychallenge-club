#! /usr/bin/python3

from collections import defaultdict

import unittest

def firstunique(s):
  cc = defaultdict(lambda: 0)
  for c in s:
    cc[c] += 1
  for (i, c) in enumerate(s):
    if cc[c] == 1:
      return i
  return -1

class TestFirstUnique(unittest.TestCase):

        def test_ex1(self):
          self.assertEqual(firstunique("Perl Weekly Challenge"),
                           0, 'example 1')

        def test_ex2(self):
          self.assertEqual(firstunique("Long Live Perl"),
                           1, 'example 2')

        def test_ex3(self):
          self.assertEqual(firstunique("aabbcc"),
                           -1, 'example 3')

unittest.main()
