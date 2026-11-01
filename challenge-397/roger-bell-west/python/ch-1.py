#! /usr/bin/python3

def absentsmallestpositive(a):
  tot = sum(a)
  ex = set(a)
  mul = len(a)
  n = 1
  while True:
    if n * mul > tot and n not in ex:
      return n
    n += 1

import unittest

class TestAbsentsmallestpositive(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(absentsmallestpositive([1, 2, 4, 5, 6]), 7, 'example 1')

  def test_ex2(self):
    self.assertEqual(absentsmallestpositive([-5, -2, -1, 3]), 1, 'example 2')

  def test_ex3(self):
    self.assertEqual(absentsmallestpositive([1, 2, 3]), 4, 'example 3')

  def test_ex4(self):
    self.assertEqual(absentsmallestpositive([2, 3, 7, 8]), 6, 'example 4')

  def test_ex5(self):
    self.assertEqual(absentsmallestpositive([1, 1, 1, 10]), 4, 'example 5')

unittest.main()
