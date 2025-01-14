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

def maximumaverage(a, n):
  mx = 0
  for s in sliding_window(a, n):
    mx = max([mx, sum(s)])
  return float(mx) / float(n)

import unittest

class TestMaximumaverage(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(maximumaverage([1, 12, -5, -6, 50, 3], 4), 12.75, 'example 1')

  def test_ex2(self):
    self.assertEqual(maximumaverage([5], 1), 5, 'example 2')

unittest.main()
