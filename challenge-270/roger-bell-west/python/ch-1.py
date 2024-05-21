#! /usr/bin/python3

def validator(a0):
  a = a0.copy()
  a.sort()
  l = len(a)
  if a[0] == 0 and a[l - 2] == 0 and a[l - 1] == 1:
    return a0.index(1)
  return -1

def specialpositions(a):
  vr = set()
  xs = set()
  for y, row in enumerate(a):
    x = validator(row)
    if (x > -1):
      vr.add((y, x))
      xs.add(x)
  xd = set()
  for x in xs:
    c = [r[x] for r in a]
    if validator(c) == -1:
      xd.add(x)
  xs -= xd
  return len([x for (y, x) in vr if x in xs])

import unittest

class TestSpecialpositions(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(specialpositions([[1, 0, 0], [0, 0, 1], [1, 0, 0]]), 1, 'example 1')

  def test_ex2(self):
    self.assertEqual(specialpositions([[1, 0, 0], [0, 1, 0], [0, 0, 1]]), 3, 'example 2')

unittest.main()
