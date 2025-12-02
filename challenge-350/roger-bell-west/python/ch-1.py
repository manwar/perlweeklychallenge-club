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

def counterify(a):
  s = collections.defaultdict(lambda: 0)
  for n in a:
    s[n] += 1
  return s

def goodsubstrings(a):
  p = 0
  for s in sliding_window(a, 3):
    c = counterify(s)
    if max(c.values()) == 1:
      p += 1
  return p

import unittest

class TestGoodsubstrings(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(goodsubstrings("abcaefg"), 5, 'example 1')

  def test_ex2(self):
    self.assertEqual(goodsubstrings("xyzzabc"), 3, 'example 2')

  def test_ex3(self):
    self.assertEqual(goodsubstrings("aababc"), 1, 'example 3')

  def test_ex4(self):
    self.assertEqual(goodsubstrings("qwerty"), 4, 'example 4')

  def test_ex5(self):
    self.assertEqual(goodsubstrings("zzzaaa"), 0, 'example 5')

unittest.main()
