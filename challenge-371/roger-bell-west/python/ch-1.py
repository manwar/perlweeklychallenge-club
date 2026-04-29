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

def missingletter(a):
  c = [ord(x) for x in a if x != " "]
  d = []
  for i in sliding_window(c, 2):
    if i[0] == 63 or i[1] == 63:
      d.append(0)
    else:
      d.append(i[1] - i[0])
  for n, delta in enumerate(d):
    if delta == 0:
      ch = 0
      if n < 2:
        ch = c[n + 2] - d[n + 2]
      else:
        ch = c[n] + d[n - 2]
      return chr(ch)
  return ""

import unittest

class TestMissingletter(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(missingletter("a c ? g i"), "e", 'example 1')

  def test_ex2(self):
    self.assertEqual(missingletter("a d ? j m"), "g", 'example 2')

  def test_ex3(self):
    self.assertEqual(missingletter("a e ? m q"), "i", 'example 3')

  def test_ex4(self):
    self.assertEqual(missingletter("a c f ? k"), "h", 'example 4')

  def test_ex5(self):
    self.assertEqual(missingletter("b e g ? l"), "j", 'example 5')

unittest.main()
