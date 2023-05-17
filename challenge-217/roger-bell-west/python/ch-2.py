#! /usr/bin/python3

def maxnumber(lst):
  po = [str(i) for i in lst]
  pl = max(len(i) for i in po)
  pm = []
  for so in po:
    sm = so
    while len(sm) < pl:
      sm += sm[-1]
    pm.append(sm)
  pi = list(range(len(pm)))
  pi.sort(key = lambda i: pm[i], reverse = True)
  return int("".join(po[st] for st in pi))

import unittest

class TestMaxnumber(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(maxnumber([1, 23]), 231, 'example 1')

  def test_ex2(self):
    self.assertEqual(maxnumber([10, 3, 2]), 3210, 'example 2')

  def test_ex3(self):
    self.assertEqual(maxnumber([31, 2, 4, 10]), 431210, 'example 3')

  def test_ex4(self):
    self.assertEqual(maxnumber([5, 11, 4, 1, 2]), 542111, 'example 4')

  def test_ex5(self):
    self.assertEqual(maxnumber([1, 10]), 110, 'example 5')

unittest.main()
