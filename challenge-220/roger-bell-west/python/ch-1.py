#! /usr/bin/python3

def word2set(word):
  r = set()
  for c in word.lower():
    if c >= 'a' and c <= 'z':
      r.add(c)
  return r

def commoncharacters(lst):
  c = word2set(lst[0])
  for w in lst[1:]:
    c = c.intersection(word2set(w))
  return sorted(list(c))

import unittest

class TestCommoncharacters(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(commoncharacters(["Perl", "Rust", "Raku"]), ["r"], 'example 1')

  def test_ex2(self):
    self.assertEqual(commoncharacters(["love", "live", "leave"]), ["e", "l", "v"], 'example 2')

unittest.main()
