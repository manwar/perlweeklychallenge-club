#! /usr/bin/python3

def duplicatezeros(a):
  out = []
  for t in a:
    out.append(t)
    if t == 0:
      out.append(t)
    if len(out) >= len(a):
      break
  if len(out) > len(a):
    out = out[0:len(a)]
  return out
      

import unittest

class TestDuplicatezeros(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(duplicatezeros([1, 0, 2, 3, 0, 4, 5, 0]), [1, 0, 0, 2, 3, 0, 0, 4], 'example 1')

  def test_ex2(self):
    self.assertEqual(duplicatezeros([1, 2, 3]), [1, 2, 3], 'example 2')

  def test_ex3(self):
    self.assertEqual(duplicatezeros([0, 3, 0, 4, 5]), [0, 0, 3, 0, 0], 'example 3')

unittest.main()
