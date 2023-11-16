#! /usr/bin/python3

from math import floor

def floorsum(a: list[int]):
  n = int(0)
  for iv in a:
    for jv in a:
      n += floor(iv / jv)
  return n

import unittest

class TestFloorsum(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(floorsum([2, 5, 9]), 10, 'example 1')

  def test_ex2(self):
    self.assertEqual(floorsum([7, 7, 7, 7, 7, 7, 7]), 49, 'example 2')

unittest.main()
