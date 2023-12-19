#! /usr/bin/python3

from collections import deque

def shortestdistance(a, c):
  q = deque()
  i = 0
  while i >= 0:
    p = a.find(c, i)
    if p >= 0:
      q.append([p, 0])
      i = p + 1
    else:
      i = -1
  invalid = len(a) + 1
  out = len(a) * [invalid]
  while len(q) > 0:
    i, v = q.popleft()
    if out[i] == invalid:
      out[i] = v
      if i > 0:
        q.append([i - 1, v + 1])
      if i < len(a) - 1:
        q.append([i + 1, v + 1])
  return out

import unittest

class TestShortestdistance(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(shortestdistance("loveleetcode", "e"), [3, 2, 1, 0, 1, 0, 0, 1, 2, 2, 1, 0], 'example 1')

  def test_ex2(self):
    self.assertEqual(shortestdistance("aaab", "b"), [3, 2, 1, 0], 'example 2')

unittest.main()
