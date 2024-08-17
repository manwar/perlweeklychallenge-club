#! /usr/bin/python3

from collections import deque

def cs2xy(a):
  x = ord(a[0]) - ord('a')
  y = ord(a[1]) - ord('1')
  return [x, y]

def knightsmove(ffrom, to):
  fc = cs2xy(ffrom)
  tc = cs2xy(to)
  queue = deque()
  queue.append((fc[0], fc[1], 0))
  seen = set()
  while len(queue) > 0:
    cc = queue.popleft()
    if cc[0] == tc[0] and cc[1] == tc[1]:
      return cc[2]
    else:
      for offset in ( (2, 1), (1, 2), (2, -1), (1, -2), (-2, 1), (-1, 2), (-2, -1), (-1, -2) ):
        x = cc[0] + offset[0]
        y = cc[1] + offset[1]
        if x >= 0 and x <= 7 and y >= 0 and y <= 7:
          cv = x * 8 + y
          if cv not in seen:
            queue.append((x, y, cc[2] + 1))
            seen.add(cv)
  return -1

import unittest

class TestKnightsmove(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(knightsmove("g2", "a8"), 4, 'example 1')

  def test_ex2(self):
    self.assertEqual(knightsmove("g2", "h2"), 3, 'example 2')

unittest.main()
