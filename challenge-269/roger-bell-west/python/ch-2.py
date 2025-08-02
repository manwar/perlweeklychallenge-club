#! /usr/bin/python3

def distributeelements(a):
  x = [a[0]]
  y = [a[1]]
  for i in range(2, len(a)):
    n = a[i]
    if x[-1] > y[-1]:
      x.append(n)
    else:
      y.append(n)
  x.extend(y)
  return x

import unittest

class TestDistributeelements(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(distributeelements([2, 1, 3, 4, 5]), [2, 3, 4, 5, 1], 'example 1')

  def test_ex2(self):
    self.assertEqual(distributeelements([3, 2, 4]), [3, 4, 2], 'example 2')

  def test_ex3(self):
    self.assertEqual(distributeelements([5, 4, 3, 8]), [5, 3, 4, 8], 'example 3')

unittest.main()
