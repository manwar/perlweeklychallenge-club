#! /usr/bin/python3

from collections import deque

def alternatecase(a):
  uppers = [c.isupper() for c in a]
  queue = deque()
  queue.append([uppers, 0])
  while len(queue) > 0:
    up, ct = queue.popleft()
    swaps = []
    for i in range(len(up) - 1):
      if up[i] == up[i + 1]:
        if i > 0:
          swaps.append(i - 1)
        if i < len(up) - 2:
          swaps.append(i + 1)
    if len(swaps) == 0:
      return ct
    for sw in swaps:
      uq = up.copy()
      uq[sw], uq[sw + 1] = uq[sw + 1], uq[sw]
      queue.append([uq, ct + 1])
  return 0

import unittest

class TestAlternatecase(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(alternatecase("aAbB"), 0, 'example 1')

  def test_ex2(self):
    self.assertEqual(alternatecase("AAbb"), 1, 'example 2')

  def test_ex3(self):
    self.assertEqual(alternatecase("AAAbbb"), 3, 'example 3')

  def test_ex4(self):
    self.assertEqual(alternatecase("aABb"), 1, 'example 4')

  def test_ex5(self):
    self.assertEqual(alternatecase("bBBAaa"), 2, 'example 5')

unittest.main()
