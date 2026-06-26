#! /usr/bin/python3

def armstrongnumber(base, limit):
  out = []
  for candidate in range(limit):
    digits = []
    if candidate == 0:
      digits.append(0)
    else:
      c = candidate
      while c > 0:
        digits.append(c % base)
        c //= base
    dl = len(digits)
    test = sum([x ** dl for x in digits])
    if test == candidate:
      out.append(candidate)
  return out

import unittest

class TestArmstrongnumber(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(armstrongnumber(10, 1000), [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 153, 370, 371, 407], 'example 1')

  def test_ex2(self):
    self.assertEqual(armstrongnumber(7, 1000), [0, 1, 2, 3, 4, 5, 6, 10, 25, 32, 45, 133, 134, 152, 250], 'example 2')

  def test_ex3(self):
    self.assertEqual(armstrongnumber(16, 1000), [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 342, 371, 520, 584, 645], 'example 3')

unittest.main()
