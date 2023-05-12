#! /usr/bin/python3

from copy import deepcopy

def word2set(word):
  r = set()
  for c in word.lower():
    if c >= 'a' and c <= 'z':
      r.add(c)
  return r

def registrationnumber(words, reg):
  s = word2set(reg)
  out = []
  for w in words:
    ss = deepcopy(s)
    for char in word2set(w):
      if char in ss:
        ss -= set(char)
        if len(ss) == 0:
          out.append(w)
          break
  return out

import unittest

class TestRegistrationnumber(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(registrationnumber(["abc", "abcd", "bcd"], "AB1 2CD"), ["abcd"], 'example 1')

  def test_ex2(self):
    self.assertEqual(registrationnumber(["job", "james", "bjorg"], "007 JB"), ["job", "bjorg"], 'example 2')

  def test_ex3(self):
    self.assertEqual(registrationnumber(["crack", "road", "rac"], "C7 RA2"), ["crack", "rac"], 'example 3')

unittest.main()
