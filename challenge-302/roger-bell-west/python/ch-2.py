#! /usr/bin/python3

def stepbystep(a):
  mv = 0
  tot = 0
  for s in a:
    tot += s
    if mv > tot:
      mv = tot
  return 1 - mv

import unittest

class TestStepbystep(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(stepbystep([-3, 2, -3, 4, 2]), 5, 'example 1')

  def test_ex2(self):
    self.assertEqual(stepbystep([1, 2]), 1, 'example 2')

  def test_ex3(self):
    self.assertEqual(stepbystep([1, -2, -3]), 5, 'example 3')

unittest.main()
