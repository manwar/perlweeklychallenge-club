#! /usr/bin/python3

def luckynumbers(a):
  maxs = set()
  for x in range(len(a[0])):
    max = (0, 0, 0)
    for y in range(len(a)):
      if a[y][x] > max[0]:
        max = (a[y][x], y, x)
    maxs.add(max)
  mins = set()
  for y in range(len(a)):
    min = (a[y][0], y, 0)
    for x in range(len(a[0])):
      if a[y][x] < min[0]:
        min = (a[y][x], y, x)
    mins.add(min)
  i = list(maxs.intersection(mins))
  if len(i) > 0:
    return i[0][0]
  return -1

import unittest

class TestLuckynumbers(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(luckynumbers([[3, 7, 9], [9, 11, 13], [15, 16, 17]]), 15, 'example 1')

  def test_ex2(self):
    self.assertEqual(luckynumbers([[1, 10, 4, 2], [9, 3, 8, 7], [15, 16, 17, 12]]), 12, 'example 2')

  def test_ex3(self):
    self.assertEqual(luckynumbers([[7, 8], [1, 2]]), 7, 'example 3')

unittest.main()
