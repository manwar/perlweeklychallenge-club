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


def mingap(a):
    mg = a[len(a) - 1] - a[0]
    mv = 0
    for p in sliding_window(a, 2):
        delta = p[1] - p[0]
        if delta < mg:
            mg = delta
            mv = p[1]
    return mv

import unittest

class TestMingap(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(mingap([2, 8, 10, 11, 15]), 11, 'example 1')

  def test_ex2(self):
    self.assertEqual(mingap([1, 5, 6, 7, 14]), 6, 'example 2')

  def test_ex3(self):
    self.assertEqual(mingap([8, 20, 25, 28]), 28, 'example 3')

unittest.main()
