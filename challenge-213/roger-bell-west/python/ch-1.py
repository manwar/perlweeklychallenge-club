#! /usr/bin/python3

import unittest

def funsort(l0):
  l = l0
  l.sort()
  a = []
  b = []
  for k in l:
    if k % 2 == 0:
      a.append(k)
    else:
      b.append(k)
  a.extend(b)
  return a

class TestFunsort(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(funsort([1, 2, 3, 4, 5, 6]), [2, 4, 6, 1, 3, 5], 'example 1')

  def test_ex2(self):
    self.assertEqual(funsort([1, 2]), [2, 1], 'example 2')

  def test_ex3(self):
    self.assertEqual(funsort([1]), [1], 'example 3')

unittest.main()
