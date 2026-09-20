#! /usr/bin/python3

def arrangebox(a0):
  a = a0
  a.sort()
  stack = []
  mx = 1
  for i in range(len(a)):
    stack.append([i, 1])
  while len(stack) > 0:
    ix, pm = stack.pop()
    if pm > mx:
      mx = pm
    for j in range(ix + 1, len(a)):
      if a[ix][0] < a[j][0] and a[ix][1] < a[j][1]:
        stack.append([j, pm + 1])
  return mx

import unittest

class TestArrangebox(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(arrangebox([[1, 3], [3, 5], [6, 8], [2, 4]]), 4, 'example 1')

  def test_ex2(self):
    self.assertEqual(arrangebox([[4, 5], [4, 6], [6, 7], [2, 3], [4, 3]]), 3, 'example 2')

  def test_ex3(self):
    self.assertEqual(arrangebox([[5, 5], [5, 5], [5, 5]]), 1, 'example 3')

  def test_ex4(self):
    self.assertEqual(arrangebox([[2, 100], [3, 200], [4, 300], [5, 50], [5, 400]]), 4, 'example 4')

  def test_ex5(self):
    self.assertEqual(arrangebox([[10, 20], [15, 10], [20, 30], [12, 18], [16, 25]]), 3, 'example 5')

unittest.main()
