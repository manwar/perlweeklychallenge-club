#! /usr/bin/python3

import collections
from itertools import islice

# https://docs.python.org/3/library/itertools.html
def sliding_window(iterable, n):
    # sliding_window('ABCDEFG', 4) --> ABCD BCDE CDEF DEFG
    it = iter(iterable)
    window = collections.deque(islice(it, n), maxlen=n)
    if len(window) == n:
        yield tuple(window)
    for x in it:
        window.append(x)
        yield tuple(window)

def findthird(s, a, b):
  ss = []
  sa = ""
  for c in s:
    if c.isalpha():
      sa += c
    else:
      if len(sa) > 0:
        ss.append(sa)
        sa = ""
  if len(sa) > 0:
    ss.append(sa)
  out = []
  for p in sliding_window(ss, 3):
    if p[0] == a and p[1] == b:
      out.append(p[2])
  return out

import unittest

class TestFindthird(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(findthird("Perl is a my favourite language but Python is my favourite too.", "my", "favourite"), ["language", "too"], 'example 1')

  def test_ex2(self):
    self.assertEqual(findthird("Barbie is a beautiful doll also also a beautiful princess.", "a", "beautiful"), ["doll", "princess"], 'example 2')

  def test_ex3(self):
    self.assertEqual(findthird("we will we will rock you rock you.", "we", "will"), ["we", "rock"], 'example 3')

unittest.main()
