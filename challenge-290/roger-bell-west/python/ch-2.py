#! /usr/bin/python3

def luhnalgorithm(a):
  digits = [int(x) for x in a if x >= '0' and x <= '9']
  payload = digits.pop()
  digits.reverse()
  for i in range(0, len(digits), 2):
    digits[i] *= 2
    if digits[i] > 9:
      digits[i] -= 9
  return 10 - (sum(digits) % 10) == payload

import unittest

class TestLuhnalgorithm(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(luhnalgorithm("17893729974"), True, 'example 1')

  def test_ex2(self):
    self.assertEqual(luhnalgorithm("4137 8947 1175 5904"), True, 'example 2')

  def test_ex3(self):
    self.assertEqual(luhnalgorithm("4137 8974 1175 5904"), False, 'example 3')

unittest.main()
