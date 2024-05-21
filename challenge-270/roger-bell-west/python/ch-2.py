#! /usr/bin/python3

from collections import deque

def equalizearray(a0, x, y):
  a = a0.copy()
  a.sort()
  limit = a[-1]
  queue = deque()
  queue.append((a, 0))
  mc = -1
  while len(queue) > 0:
    op = queue.popleft()
    if mc == -1 or mc > op[1]:
      if op[0][0] == op[0][-1]:
        mc = op[1]
      else:
        p = op[0].copy()
        p[0] += 1
        if p[0] <= limit:
          p.sort()
          queue.append((p, op[1] + x))
          q = op[0].copy()
          q[0] += 1;
          q[1] += 1;
          if q[1] <= limit:
            q.sort()
            queue.append((q, op[1] + y))
  return mc

import unittest

class TestEqualizearray(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(equalizearray([4, 1], 3, 2), 9, 'example 1')

  def test_ex2(self):
    self.assertEqual(equalizearray([2, 3, 3, 3, 5], 2, 1), 6, 'example 2')

unittest.main()
