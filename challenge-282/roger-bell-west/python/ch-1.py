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

def goodinteger(a):
  winsize = 3
  d = str(a)
  for offset, cc in enumerate(sliding_window(d, winsize)):
    if cc[0] == cc[1] and cc[1] == cc[2]:
      if (offset == 0 or d[offset - 1] != cc[0]) and (offset == len(d) - winsize or d[offset + winsize] != cc[2]):
        return int("".join(cc))
  return -1

import unittest

class TestGoodinteger(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(goodinteger(12344456), 444, 'example 1')

  def test_ex2(self):
    self.assertEqual(goodinteger(1233334), -1, 'example 2')

  def test_ex3(self):
    self.assertEqual(goodinteger(10020003), 0, 'example 3')

unittest.main()
