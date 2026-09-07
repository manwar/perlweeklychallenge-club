#! /usr/bin/python3

def zigzagsubarray(a):
  mx = min(len(a), 1)
  for i in range(len(a)):
    o = 0
    lastdir = 0
    for j in range(i, len(a)):
      thisdir = 0
      if j > i:
        if a[j] > o:
          thisdir = 1
          mx = max(mx, 2)
        elif a[j] < o:
          thisdir = -1
          mx = max(mx, 2)
      if (j > i and thisdir == 0) or (j > i + 1 and thisdir * lastdir != -1):
        break
      o = a[j]
      lastdir = thisdir
      mx = max(mx, j - i + 1)
  return mx
  
import unittest

class TestZigzagsubarray(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(zigzagsubarray([9, 4, 2, 10, 7, 8, 8, 1, 9]), 5, 'example 1')

  def test_ex2(self):
    self.assertEqual(zigzagsubarray([1, 7, 4, 9, 2, 5]), 6, 'example 2')

  def test_ex3(self):
    self.assertEqual(zigzagsubarray([1, 2, 3, 4, 5]), 2, 'example 3')

  def test_ex4(self):
    self.assertEqual(zigzagsubarray([4, 4, 4]), 1, 'example 4')

  def test_ex5(self):
    self.assertEqual(zigzagsubarray([10, 20, 15, 12, 18]), 3, 'example 5')

unittest.main()
