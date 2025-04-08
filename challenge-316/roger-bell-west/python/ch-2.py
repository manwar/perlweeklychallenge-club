#! /usr/bin/python3

def subsequence(a, b):
  l = a
  s = b
  if len(a) < len(b):
    l = b
    s = a
  si = 0
  for c in l:
    if c == s[si]:
      si += 1
      if si >= len(s):
        return True
  return False

import unittest

class TestSubsequence(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(subsequence("uvw", "bcudvew"), True, 'example 1')

  def test_ex2(self):
    self.assertEqual(subsequence("aec", "abcde"), False, 'example 2')

  def test_ex3(self):
    self.assertEqual(subsequence("sip", "javascript"), True, 'example 3')

unittest.main()
