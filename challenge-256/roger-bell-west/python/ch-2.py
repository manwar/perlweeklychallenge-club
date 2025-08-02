#! /usr/bin/python3

def mergestrings(a, b):
  out = ""
  for i in range(max(len(a), len(b))):
    if i < len(a):
      out += a[i]
    if i < len(b):
      out += b[i]
  return out

import unittest

class TestMergestrings(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(mergestrings("abcd", "1234"), "a1b2c3d4", 'example 1')

  def test_ex2(self):
    self.assertEqual(mergestrings("abc", "12345"), "a1b2c345", 'example 2')

  def test_ex3(self):
    self.assertEqual(mergestrings("abcde", "123"), "a1b2c3de", 'example 3')

unittest.main()
