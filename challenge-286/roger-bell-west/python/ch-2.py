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

def ordergame(a):
  p = a
  while len(p) > 1:
    q = []
    mm = True
    for j  in sliding_window(p, 2):
      if mm:
        q.append(min(j))
      else:
        q.append(max(j))
      mm = not mm
    p = q
  return p[0]
    

import unittest

class TestOrdergame(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(ordergame([2, 1, 4, 5, 6, 3, 0, 2]), 1, 'example 1')

  def test_ex2(self):
    self.assertEqual(ordergame([0, 5, 3, 2]), 0, 'example 2')

  def test_ex3(self):
    self.assertEqual(ordergame([9, 2, 1, 4, 5, 6, 0, 7, 3, 1, 3, 5, 7, 9, 0, 8]), 2, 'example 3')

unittest.main()
