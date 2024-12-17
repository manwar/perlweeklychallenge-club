#! /usr/bin/python3

def beautifularrangement(a):
  precalc = [[False] * (a + 1) for i in range(a + 1)]
  for i in range(1, a + 1):
    for j in range(i, a + 1, i):
      precalc[i][j] = True
      precalc[j][i] = True
  ct = 0
  stack = []
  stack.append(list(range(1, a + 1)))
  while len(stack) > 0:
    trail = stack.pop()
    if len(trail) == 1:
      ct += 1
    else:
      p = a - len(trail) + 2
      for i in trail:
        if precalc[i][p]:
          tt = [x for x in trail if x != i]
          stack.append(tt)
  return ct

import unittest

class TestBeautifularrangement(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(beautifularrangement(2), 2, 'example 1')

  def test_ex2(self):
    self.assertEqual(beautifularrangement(1), 1, 'example 2')

  def test_ex3(self):
    self.assertEqual(beautifularrangement(10), 700, 'example 3')

  def test_ex4(self):
    self.assertEqual(beautifularrangement(20), 1939684, 'example 4')

unittest.main()
