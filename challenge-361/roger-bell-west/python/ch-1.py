#! /usr/bin/python3

def zeckendorfrepresentation(a):
  fib = [0, 1]
  while fib[-1] <= a:
    fib.append(fib[-1] + fib[-2])
  fib.pop()
  res = []
  aw = a
  while aw > 0:
    res.append(fib[-1])
    aw -= fib[-1]
    fib.pop()
    fib.pop()
    while fib[-1] > aw:
      fib.pop()
  return res    

import unittest

class TestZeckendorfrepresentation(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(zeckendorfrepresentation(4), [3, 1], 'example 1')

  def test_ex2(self):
    self.assertEqual(zeckendorfrepresentation(12), [8, 3, 1], 'example 2')

  def test_ex3(self):
    self.assertEqual(zeckendorfrepresentation(20), [13, 5, 2], 'example 3')

  def test_ex4(self):
    self.assertEqual(zeckendorfrepresentation(96), [89, 5, 2], 'example 4')

  def test_ex5(self):
    self.assertEqual(zeckendorfrepresentation(100), [89, 8, 3], 'example 5')

unittest.main()
