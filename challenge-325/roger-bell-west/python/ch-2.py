#! /usr/bin/python3

def finalprice(a):
  out = []
  for i, n in enumerate(a):
    discount = 0
    for mi in range(i + 1, len(a)):
      if a[mi] <= n:
        discount = a[mi]
        break
    out.append(n - discount)
  return out

import unittest

class TestFinalprice(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(finalprice([8, 4, 6, 2, 3]), [4, 2, 4, 2, 3], 'example 1')

  def test_ex2(self):
    self.assertEqual(finalprice([1, 2, 3, 4, 5]), [1, 2, 3, 4, 5], 'example 2')

  def test_ex3(self):
    self.assertEqual(finalprice([7, 1, 1, 5]), [6, 0, 1, 5], 'example 3')

unittest.main()
