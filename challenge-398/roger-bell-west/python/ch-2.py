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

def stringdifference(a):
  da = []
  for s in a:
    p = []
    for d in sliding_window(s, 2):
      p.append(ord(d[1]) - ord(d[0]))
    da.append(p)
  dx = 0
  for b in range(1, len(a)):
    if da[0] != da[b]:
      if dx > 0:
        dx = 0
        break
      else:
        dx = b
  return a[dx]

import unittest

class TestStringdifference(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(stringdifference(["ab", "bc", "cd", "zy"]), "zy", 'example 1')

  def test_ex2(self):
    self.assertEqual(stringdifference(["cba", "fed", "azy"]), "azy", 'example 2')

  def test_ex3(self):
    self.assertEqual(stringdifference(["pop", "ada", "beb", "cfc"]), "pop", 'example 3')

  def test_ex4(self):
    self.assertEqual(stringdifference(["aaaa", "zzzz", "mmmm", "aaba"]), "aaba", 'example 4')

  def test_ex5(self):
    self.assertEqual(stringdifference(["aceg", "bdfh", "cegi", "azbz"]), "azbz", 'example 5')

unittest.main()
