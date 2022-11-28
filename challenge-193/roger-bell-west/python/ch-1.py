#! /usr/bin/python3

import unittest

def binarystring(n):
  o = []
  for a in range(1 << n):
    o.append("{0:0>{w}b}".format(a, w=n))
  return o

class TestBinarystring(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(binarystring(2), ["00", "01", "10", "11"], 'example 1')

  def test_ex2(self):
    self.assertEqual(binarystring(3), ["000", "001", "010", "011", "100", "101", "110", "111"], 'example 2')

unittest.main()
