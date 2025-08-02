#! /usr/bin/python3

def sortoddeven(a):
  odds = []
  evens = []
  for i, x in enumerate(a):
    if i % 2 == 0:
      evens.append(x)
    else:
      odds.append(x)
  evens.sort()
  odds.sort()
  odds.reverse()
  out = []
  for i in range(max(len(evens), len(odds))):
    if i < len(evens):
      out.append(evens[i])
    if i < len(odds):
      out.append(odds[i])
  return out

import unittest

class TestSortoddeven(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(sortoddeven([4, 1, 2, 3]), [2, 3, 4, 1], 'example 1')

  def test_ex2(self):
    self.assertEqual(sortoddeven([3, 1]), [3, 1], 'example 2')

  def test_ex3(self):
    self.assertEqual(sortoddeven([5, 3, 2, 1, 4]), [2, 3, 4, 1, 5], 'example 3')

unittest.main()
