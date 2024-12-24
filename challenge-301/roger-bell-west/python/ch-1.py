#! /usr/bin/python3

from functools import cmp_to_key

def cmp(a, b):
  return (a > b) - (a < b) 

def numcat(i, j):
  ij = i + j
  ji = j + i
  return cmp(int(ij), int(ji))

def largestnumber(a):
  ax = [str(x) for x in a]
  ax.sort(key = cmp_to_key(numcat))
  ax.reverse()
  return int("".join(ax))

import unittest

class TestLargestnumber(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(largestnumber([20, 3]), 320, 'example 1')

  def test_ex2(self):
    self.assertEqual(largestnumber([3, 30, 34, 5, 9]), 9534330, 'example 2')

unittest.main()
