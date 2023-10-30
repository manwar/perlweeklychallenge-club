#! /usr/bin/python3

def persistence(a):
  steps = 0
  b = a
  while b > 9:
    steps += 1
    p = 1
    while b > 0:
      p *= b % 10
      b //= 10
    b = p
  return steps

def persistencearray(a):
  c = dict()
  for i in a:
    c[i] = persistence(i)
  b = a
  b.sort()
  b.sort(key = lambda i: c[i])
  return b

import unittest

class TestPersistencearray(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(persistencearray([15, 99, 1, 34]), [1, 15, 34, 99], 'example 1')

  def test_ex2(self):
    self.assertEqual(persistencearray([50, 25, 33, 22]), [22, 33, 50, 25], 'example 2')

unittest.main()
