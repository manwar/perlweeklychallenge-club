#! /usr/bin/python3

from itertools import islice
from collections import deque,defaultdict

# https://docs.python.org/3/library/itertools.html
def sliding_window(iterable, n):
    # sliding_window('ABCDEFG', 4) --> ABCD BCDE CDEF DEFG
    it = iter(iterable)
    window = deque(islice(it, n), maxlen=n)
    if len(window) == n:
        yield tuple(window)
    for x in it:
        window.append(x)
        yield tuple(window)

def shortestroute(r0, origin, destination):
  r = defaultdict(set)
  for rt in r0:
    for rp in sliding_window(rt, 2):
      r[rp[0]].add(rp[1])
      r[rp[1]].add(rp[0])
  out = []
  stack = deque()
  stack.append([[origin], set([origin])])
  while len(stack) > 0:
    s = stack.popleft()
    l = s[0][-1]
    if l == destination:
      out = s[0]
      break
    else:
      for pd in r[l] - s[1]:
        q = [s[0].copy(), s[1].copy()]
        q[0].append(pd)
        q[1].discard(pd)
        stack.append(q)
  return out
      

import unittest

class TestShortestroute(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(shortestroute([[1, 2, 6], [5, 6, 7]], 1, 7), [1, 2, 6, 7], 'example 1')

  def test_ex2(self):
    self.assertEqual(shortestroute([[1, 2, 3], [4, 5, 6]], 2, 5), [], 'example 2')

  def test_ex3(self):
    self.assertEqual(shortestroute([[1, 2, 3], [4, 5, 6], [3, 8, 9], [7, 8]], 1, 7), [1, 2, 3, 8, 7], 'example 3')

unittest.main()
