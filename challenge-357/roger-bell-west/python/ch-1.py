#! /usr/bin/python3

def a2n(a):
  t = 0
  for d in a:
    t *= 10
    t += d
  return t

def kaprekarconstant(a):
  ct = 0
  b = a
  while b != 6174:
    if b == 0:
      return -1
    digits = []
    for _ in range(4):
      digits.append(b % 10)
      b //= 10
    digits.sort()
    stigid = digits.copy()
    stigid.reverse()
    b = a2n(stigid) - a2n(digits)
    ct += 1
  return ct
  
import unittest

class TestKaprekarconstant(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(kaprekarconstant(3524), 3, 'example 1')

  def test_ex2(self):
    self.assertEqual(kaprekarconstant(6174), 0, 'example 2')

  def test_ex3(self):
    self.assertEqual(kaprekarconstant(9998), 5, 'example 3')

  def test_ex4(self):
    self.assertEqual(kaprekarconstant(1001), 4, 'example 4')

  def test_ex5(self):
    self.assertEqual(kaprekarconstant(9000), 4, 'example 5')

  def test_ex6(self):
    self.assertEqual(kaprekarconstant(1111), -1, 'example 6')

unittest.main()
