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

def circular(a):
  for p in sliding_window(a, 2):
    if p[0][-1] != p[1][0]:
      return False
  return True

import unittest

class TestCircular(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(circular(["perl", "loves", "scala"]), True, 'example 1')

  def test_ex2(self):
    self.assertEqual(circular(["love", "the", "programming"]), False, 'example 2')

  def test_ex3(self):
    self.assertEqual(circular(["java", "awk", "kotlin", "node.js"]), True, 'example 3')

unittest.main()
