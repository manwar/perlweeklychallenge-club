#! /usr/bin/python3

import unittest

def esthetic(n0, base):
  n = n0
  pdigit = 0
  ch = False
  while n > 0:
    digit = n % base
    if ch and abs(digit - pdigit) != 1:
      return False
    ch = True
    pdigit = digit
    n //= base
  return True

def esthetic10(n):
  return esthetic(n, 10)

class TestEsthetic(unittest.TestCase):

        def test_ex1(self):
          self.assertEqual(esthetic10(5456),True,'example 1')

        def test_ex2(self):
          self.assertEqual(esthetic10(120),False,'example 1')

        def test_ex3(self):
          self.assertEqual(esthetic10(12),True,'example 1')

        def test_ex4(self):
          self.assertEqual(esthetic10(5654),True,'example 1')

        def test_ex5(self):
          self.assertEqual(esthetic10(890),False,'example 1')

unittest.main()
