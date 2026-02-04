#! /usr/bin/python3

def digitalroot(a):
  count = 0
  value = a
  while value > 9:
    p = 0
    while value > 0:
      p += value % 10
      value //= 10
    value = p
    count += 1
  return [count, value]

import unittest

class TestDigitalroot(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(digitalroot(38), [2, 2], 'example 1')

  def test_ex2(self):
    self.assertEqual(digitalroot(7), [0, 7], 'example 2')

  def test_ex3(self):
    self.assertEqual(digitalroot(999), [2, 9], 'example 3')

  def test_ex4(self):
    self.assertEqual(digitalroot(1999999999), [3, 1], 'example 4')

  def test_ex5(self):
    self.assertEqual(digitalroot(101010), [1, 3], 'example 5')

unittest.main()
