#! /usr/bin/python3

import unittest
from collections import defaultdict

def oddstring(ss):
  for i in range(len(ss[0])-1):
    tab = defaultdict(list)
    for s in ss:
      tab[ord(s[i+1]) - ord(s[i])].append(s)
    for j in tab.values():
      if len(j) == 1:
        return j[0]
  return ""

class TestOddstring(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(oddstring(["adc", "wzy", "abc"]), "abc", "example 1")

  def test_ex2(self):
    self.assertEqual(oddstring(["aaa", "bob", "ccc", "ddd"]), "bob", "example 2")

unittest.main()
