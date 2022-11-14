#! /usr/bin/python3

import unittest

def cutelist(n):
  tab = [[False]]
  for x in range(1, n+1):
    tab.append([False] * (n+1))
  for x in range(1, n+1):
    for y in range(1, x+1):
      if x % y != 0 and y % x != 0:
        tab[x][y] = True
        tab[y][x] = True
  count = 0
  stackl = [[]]
  stackc = [[x for x in range(1,n+1)]]
  while len(stackl) > 0:
    l = stackl.pop()
    c = stackc.pop()
    if len(c) == 0 and len(l) == n:
      count += 1
    else:
      place = len(l) + 1
      for candidate in c:
        if not tab[place][candidate]:
          q = l.copy()
          q.append(candidate)
          stackl.append(q)
          stackc.append([i for i in c if i != candidate])
  return count

class TestCutelist(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(cutelist(2), 2, 'example 1')

  def test_ex2(self):
    self.assertEqual(cutelist(10), 700, 'example 2')

  def test_ex3(self):
    self.assertEqual(cutelist(15), 24679, 'example 3')

unittest.main()
