#! /usr/bin/python3

from collections import Counter

def word2map(word):
  m = Counter()
  for c in word.lower():
    m[c] += 1
  return m

def specialnotes(chars, word):
  cm = word2map(chars)
  f = word2map(word)
  valid = True
  for c in f.keys():
    if f[c] > cm[c]:
      valid = False
      break
  return valid

import unittest

class TestSpecialnotes(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(specialnotes("abc", "xyz"), False, 'example 1')

  def test_ex2(self):
    self.assertEqual(specialnotes("scriptinglanguage", "perl"), True, 'example 2')

  def test_ex3(self):
    self.assertEqual(specialnotes("aabbcc", "abc"), True, 'example 3')

unittest.main()
