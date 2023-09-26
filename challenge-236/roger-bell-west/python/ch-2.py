#! /usr/bin/python3

def arrayloops(a):
  loop_id = 0
  loops = dict()
  for origin in range(len(a)):
    if origin not in loops:
      li = 0
      thisloop = set()
      x = origin
      while True:
        if x < 0 or x >= len(a):
          break
        thisloop.add(x)
        x = a[x]
        if x in loops:
          li = loops[x]
          break
        if x in thisloop:
          loop_id += 1
          li = loop_id
          break
    for i in thisloop:
      loops[i] = li
  return loop_id

import unittest

class TestArrayloops(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(arrayloops([4, 6, 3, 8, 15, 0, 13, 18, 7, 16, 14, 19, 17, 5, 11, 1, 12, 2, 9, 10]), 3, 'example 1')

  def test_ex2(self):
    self.assertEqual(arrayloops([0, 1, 13, 7, 6, 8, 10, 11, 2, 14, 16, 4, 12, 9, 17, 5, 3, 18, 15, 19]), 6, 'example 2')

  def test_ex3(self):
    self.assertEqual(arrayloops([9, 8, 3, 11, 5, 7, 13, 19, 12, 4, 14, 10, 18, 2, 16, 1, 0, 15, 6, 17]), 1, 'example 3')

unittest.main()
