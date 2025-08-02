#! /usr/bin/python3

from collections import defaultdict
import re

def mostfrequentword(para, banned):
  words = defaultdict(lambda: 0)
  r = re.compile(r"[^A-Za-z]+")
  for v in re.split(r, para):
    if len(v) > 0:
      words[v] += 1
  del words[banned]
  m = max(words.values())
  v = [w for w in words.keys() if words[w] == m]
  v.sort()
  return v[0]

import unittest

class TestMostfrequentword(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(mostfrequentword("Joe hit a ball, the hit ball flew far after it was hit.", "hit"), "ball", 'example 1')

  def test_ex2(self):
    self.assertEqual(mostfrequentword("Perl and Raku belong to the same family. Perl is the most popular language in the weekly challenge.", "the"), "Perl", 'example 2')

unittest.main()
