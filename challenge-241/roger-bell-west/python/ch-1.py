#! /usr/bin/python3

def arithmetictriplets(nums, diff):
  ns = set(nums)
  return len([n for n in nums if (n + diff) in ns and (n + diff * 2) in ns])

import unittest

class TestArithmetictriplets(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(arithmetictriplets([0, 1, 4, 6, 7, 10], 3), 2, 'example 1')

  def test_ex2(self):
    self.assertEqual(arithmetictriplets([4, 5, 6, 7, 8, 9], 2), 2, 'example 2')

unittest.main()
