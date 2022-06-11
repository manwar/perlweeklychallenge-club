#! /usr/bin/python3

import unittest

def plan(houses):
  terminal=len(houses)-2
  b=[[0]]
  reward=0
  while len(b) > 0:
    c=b.pop()
    if c[-1] >= terminal:
      r=sum(houses[i] for i in c)
      if r > reward:
        reward=r
    else:
      for n in range(c[-1]+2,c[-1]+4):
        if n >= len(houses):
          break
        j=c.copy()
        j.append(n)
        b.append(j)
  return reward

class TestPlan(unittest.TestCase):

        def test_ex1(self):
          self.assertEqual(plan([2, 4, 5]),7,'example 1')

        def test_ex2(self):
          self.assertEqual(plan([4, 2, 3, 6, 5, 3]),13,'example 2')

unittest.main()
