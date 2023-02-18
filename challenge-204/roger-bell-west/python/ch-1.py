#! /usr/bin/python3

import unittest

from itertools import islice
import collections

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

def monotonicarray(l):
  d = [v[1] - v[0] for v in sliding_window(l, 2)]
  return min(d) * max(d) >= 0

class TestMonotonicarray(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(monotonicarray([1, 2, 2, 3]), True, 'example 1')

  def test_ex2(self):
    self.assertEqual(monotonicarray([1, 3, 2]), False, 'example 2')

  def test_ex3(self):
    self.assertEqual(monotonicarray([6, 5, 5, 4]), True, 'example 3')

unittest.main()
