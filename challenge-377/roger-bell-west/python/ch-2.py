#! /usr/bin/python3

def prefixsuffix(a0):
  tot = 0
  a = a0
  a.sort(key = len)
  for si in range(len(a) - 1):
    for li in range(si + 1, len(a)):
      if a[li].find(a[si]) != -1 and a[li].rfind(a[si]) == len(a[li]) - len(a[si]):
        tot += 1
  return tot

import unittest

class TestPrefixsuffix(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(prefixsuffix(["a", "aba", "ababa", "aa"]), 4, 'example 1')

  def test_ex2(self):
    self.assertEqual(prefixsuffix(["pa", "papa", "ma", "mama"]), 2, 'example 2')

  def test_ex3(self):
    self.assertEqual(prefixsuffix(["abao", "abab"]), 0, 'example 3')

  def test_ex4(self):
    self.assertEqual(prefixsuffix(["abab", "abab"]), 1, 'example 4')

  def test_ex5(self):
    self.assertEqual(prefixsuffix(["ab", "abab", "ababab"]), 3, 'example 5')

unittest.main()
