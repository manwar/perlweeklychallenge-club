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

def stringscore(a):
  out = 0
  for i in sliding_window(a, 2):
    out += abs(ord(i[0]) - ord(i[1]))
  return out

import unittest

class TestStringscore(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(stringscore("hello"), 13, 'example 1')

  def test_ex2(self):
    self.assertEqual(stringscore("perl"), 30, 'example 2')

  def test_ex3(self):
    self.assertEqual(stringscore("raku"), 37, 'example 3')

unittest.main()
