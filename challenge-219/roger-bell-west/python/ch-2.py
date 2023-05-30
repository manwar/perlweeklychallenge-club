#! /usr/bin/python3

from collections import deque

def travelexpenditure(costs, days0):
  days = sorted(days0)
  validities = [1, 7, 30]
  stack = deque()
  stack.append([0, days])
  cheapest = len(days) * costs[0]
  while len(stack) > 0:
    c = stack.popleft()
    if len(c[1]) == 0:
      if c[0] < cheapest:
        cheapest = c[0]
    else:
      if c[0] >= cheapest:
        continue
      start = c[1][0]
      for i in range(3):
        end = start + validities[i] - 1
        dtd = list(filter(lambda x: x > end, c[1]))
        stack.append([c[0] + costs[i], dtd])
  return cheapest

import unittest

class TestTravelexpenditure(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(travelexpenditure([2, 7, 25], [1, 5, 6, 7, 9, 15]), 11, 'example 1')

  def test_ex2(self):
    self.assertEqual(travelexpenditure([2, 7, 25], [1, 2, 3, 5, 7, 10, 11, 12, 14, 20, 30, 31]), 20, 'example 2')

unittest.main()
