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

def oddsum(a):
  out = sum(a)
  l = 3
  while l <= len(a):
    for s in sliding_window(a, l):
      out += sum(s)
    l += 2
  return out

import unittest

class TestOddsum(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(oddsum([2, 5, 3, 6, 4]), 77, 'example 1')

  def test_ex2(self):
    self.assertEqual(oddsum([1, 3]), 4, 'example 2')

unittest.main()
