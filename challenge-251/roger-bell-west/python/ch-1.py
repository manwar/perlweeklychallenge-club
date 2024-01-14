#! /usr/bin/python3

def concat(a0, b0):
  if b0 == 0:
    return 10 * a0
  a = a0
  b = b0
  while b > 0:
    a *= 10
    b = int(b / 10)
  return a + b0

def concatenationvalue(a):
  t = 0
  for i in range(int((len(a) - 1)/2) + 1):
    j = len(a) - 1 - i
    if j == i:
      t += a[i]
    else:
      t += concat(a[i], a[j])
  return t

import unittest

class TestConcatenationvalue(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(concatenationvalue([6, 12, 25, 1]), 1286, 'example 1')

  def test_ex2(self):
    self.assertEqual(concatenationvalue([10, 7, 31, 5, 2, 2]), 489, 'example 2')

  def test_ex3(self):
    self.assertEqual(concatenationvalue([1, 2, 10]), 112, 'example 3')

unittest.main()
