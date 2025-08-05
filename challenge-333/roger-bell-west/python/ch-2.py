#! /usr/bin/python3

def duplicatezeros(a):
  b = []
  for n in a:
    b.append(n)
    if len(a) == len(b):
      break
    if n == 0:
      b.append(0)
      if len(a) == len(b):
        break
  return b

import unittest

class TestDuplicatezeros(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(duplicatezeros([1, 0, 2, 3, 0, 4, 5, 0]), [1, 0, 0, 2, 3, 0, 0, 4], 'example 1')

  def test_ex2(self):
    self.assertEqual(duplicatezeros([1, 2, 3]), [1, 2, 3], 'example 2')

  def test_ex3(self):
    self.assertEqual(duplicatezeros([1, 2, 3, 0]), [1, 2, 3, 0], 'example 3')

  def test_ex4(self):
    self.assertEqual(duplicatezeros([0, 0, 1, 2]), [0, 0, 0, 0], 'example 4')

  def test_ex5(self):
    self.assertEqual(duplicatezeros([1, 2, 0, 3, 4]), [1, 2, 0, 0, 3], 'example 5')

unittest.main()
