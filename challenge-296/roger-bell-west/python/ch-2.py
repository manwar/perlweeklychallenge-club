#! /usr/bin/python3

def matchsticksquare(a):
  perimeter = sum(a)
  if perimeter % 4 != 0:
    return False
  side = perimeter / 4
  ss = list(reversed(sorted(a)))
  sidesleft = 4
  lengthleft = side
  while True:
    leftover = []
    for m in ss:
      if m > side:
        return False
      if m <= lengthleft:
        lengthleft -= m
        if lengthleft == 0:
          sidesleft -= 1
          lengthleft = side
      else:
        leftover.append(m)
    if len(leftover) == 0:
      break
    ss = leftover
  return sidesleft == 0 and lengthleft == side

import unittest

class TestMatchsticksquare(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(matchsticksquare([1, 2, 2, 2, 1]), True, 'example 1')

  def test_ex2(self):
    self.assertEqual(matchsticksquare([2, 2, 2, 4]), False, 'example 2')

  def test_ex3(self):
    self.assertEqual(matchsticksquare([2, 2, 2, 2, 4]), False, 'example 3')

  def test_ex4(self):
    self.assertEqual(matchsticksquare([3, 4, 1, 4, 3, 1]), True, 'example 4')

unittest.main()
