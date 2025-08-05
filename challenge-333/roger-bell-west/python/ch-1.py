#! /usr/bin/python3

def straightline(a):
  b = []
  for xy in a:
    u = True
    for bxy in b:
      if xy[0] == bxy[0] and xy[1] == bxy[1]:
        u = False
        break
    if u:
      b.append(xy)
  if len(b) < 3:
    return True
  p = b[0][0]
  q = b[1][0] - b[0][0]
  r = b[0][1]
  s = b[1][1] - b[0][1]
  for tp in range(2, len(b)):
    tpair = b[tp]
    if q == 0. and tpair[0] != b[0][0]:
      return False
    if s == 0. and tpair[1] != b[0][1]:
      return False
    if q != 0 and s != 0:
      n1 = (tpair[0] - p) / q
      n2 = (tpair[1] - r) / s
      if n1 != n2:
        return False
  return True

import unittest

class TestStraightline(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(straightline([[2, 1], [2, 3], [2, 5]]), True, 'example 1')

  def test_ex2(self):
    self.assertEqual(straightline([[1, 4], [3, 4], [10, 4]]), True, 'example 2')

  def test_ex3(self):
    self.assertEqual(straightline([[0, 0], [1, 1], [2, 3]]), False, 'example 3')

  def test_ex4(self):
    self.assertEqual(straightline([[1, 1], [1, 1], [1, 1]]), True, 'example 4')

unittest.main()
