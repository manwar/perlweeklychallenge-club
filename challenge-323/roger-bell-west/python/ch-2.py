#! /usr/bin/python3

def taxamount(income, brackets):
  tax = 0
  lastbracket = 0
  for bracket in brackets:
    if income > lastbracket:
      tax += (min(income, bracket[0]) - lastbracket) * bracket[1]
    else:
      break
    lastbracket = bracket[0]
  return tax / 100

import unittest

class TestTaxamount(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(taxamount(10, [[3, 50], [7, 10], [12, 25]]), 2.65, 'example 1')

  def test_ex2(self):
    self.assertEqual(taxamount(2, [[1, 0], [4, 25], [5, 50]]), 0.25, 'example 2')

  def test_ex3(self):
    self.assertEqual(taxamount(0, [[2, 50]]), 0, 'example 3')

unittest.main()
