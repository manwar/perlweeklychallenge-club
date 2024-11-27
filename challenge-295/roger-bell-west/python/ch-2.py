#! /usr/bin/python3

def jumpgame(a):
  target = len(a) - 1
  here = set()
  here.add(0)
  moves = 0
  while True:
    moves += 1
    there = set()
    for n in here:
      for i in range(n + 1, 1 + min(n + a[n], target)):
        there.add(i)
    if len(there) == 0:
      return -1
    if target in there:
      return moves
    here = there

import unittest

class TestJumpgame(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(jumpgame([2, 3, 1, 1, 4]), 2, 'example 1')

  def test_ex2(self):
    self.assertEqual(jumpgame([2, 3, 0, 4]), 2, 'example 2')

  def test_ex3(self):
    self.assertEqual(jumpgame([2, 0, 0, 4]), -1, 'example 3')

unittest.main()
