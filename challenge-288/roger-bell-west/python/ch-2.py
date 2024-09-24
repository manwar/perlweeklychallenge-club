#! /usr/bin/python3

from collections import deque

def contiguousblock(a):
  y = len(a)
  x = len(a[0])
  starts = set()
  for cx in range(x):
    for cy in range(y):
      starts.add((cx, cy))
  maxblock = 0
  while len(starts) > 0:
    start = list(starts)[0]
    queue = deque()
    visited = set()
    visited.add(start)
    queue.append(start)
    while len(queue) > 0:
      here = queue.popleft()
      for delta in ( (-1, 0), (1, 0), (0, -1), (0, 1) ):
        if (delta[0] >= 0 or here[0] > 0) and (delta[0] <= 0 or here[0] < x - 1) and (delta[1] >= 0 or here[1] > 0) and (delta[1] <= 0 or here[1] < y - 1):
          there = (here[0] + delta[0], here[1] + delta[1])
          if there not in visited and a[there[1]][there[0]] == a[start[1]][start[0]]:
            visited.add(there)
            queue.append(there)
    sz = len(visited)
    if sz > maxblock:
      maxblock = sz
    starts = starts.difference(visited)
  return maxblock
           

import unittest

class TestContiguousblock(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(contiguousblock([["x", "x", "x", "x", "o"], ["x", "o", "o", "o", "o"], ["x", "o", "o", "o", "o"], ["x", "x", "x", "o", "o"]]), 11, 'example 1')

  def test_ex2(self):
    self.assertEqual(contiguousblock([["x", "x", "x", "x", "x"], ["x", "o", "o", "o", "o"], ["x", "x", "x", "x", "o"], ["x", "o", "o", "o", "o"]]), 11, 'example 2')

  def test_ex3(self):
    self.assertEqual(contiguousblock([["x", "x", "x", "o", "o"], ["o", "o", "o", "x", "x"], ["o", "x", "x", "o", "o"], ["o", "o", "o", "x", "x"]]), 7, 'example 3')

unittest.main()
