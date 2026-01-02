#! /usr/bin/python3

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

def minabsdiff(a):
  b = a
  b.sort()
  out = []
  mindiff = 1 + b[-1] - b[0]
  for c in sliding_window(b, 2):
    d = c[1] - c[0]
    if d < mindiff:
      out = []
      mindiff = d
    if d == mindiff:
      out.append(list(c))
  return out

import unittest

class TestMinabsdiff(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(minabsdiff([4, 2, 1, 3]), [[1, 2], [2, 3], [3, 4]], 'example 1')

  def test_ex2(self):
    self.assertEqual(minabsdiff([10, 100, 20, 30]), [[10, 20], [20, 30]], 'example 2')

  def test_ex3(self):
    self.assertEqual(minabsdiff([-5, -2, 0, 3]), [[-2, 0]], 'example 3')

  def test_ex4(self):
    self.assertEqual(minabsdiff([8, 1, 15, 3]), [[1, 3]], 'example 4')

  def test_ex5(self):
    self.assertEqual(minabsdiff([12, 5, 9, 1, 15]), [[9, 12], [12, 15]], 'example 5')

unittest.main()
