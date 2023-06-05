#! /usr/bin/python3

import collections
from itertools import permutations, islice

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

def squared(a):
  return a * a

def squareful(lst):
  results = set()
  squares = set()
  for la in permutations(lst):
    squareful = True
    for a in sliding_window(la, 2):
      cs = a[0] + a[1]
      mx = squared(len(squares))
      while cs > mx:
        mx = squared(len(squares) + 1)
        squares.add(mx)
      if cs not in squares:
        squareful = False
        break
    if squareful:
      results.add(tuple(la))
  o = list(results)
  o.sort()
  return [ list(x) for x in o ]


import unittest

class TestSquareful(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(squareful([1, 17, 8]), [[1, 8, 17], [17, 8, 1]], 'example 1')

  def test_ex2(self):
    self.assertEqual(squareful([2, 2, 2]), [[2, 2, 2]], 'example 2')

unittest.main()
