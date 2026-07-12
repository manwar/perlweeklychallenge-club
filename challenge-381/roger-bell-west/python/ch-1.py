#! /usr/bin/python3

def samerowcolumn(a):
  for row in a:
    notfound = set(range(1, len(row) + 1))
    for n in row:
      notfound.discard(n)
    if len(notfound) > 0:
      return False
  for coln in range(len(a[0])):
    notfound = set(range(1, len(a) + 1))
    for row in a:
      notfound.discard(row[coln])
    if len(notfound) > 0:
      return False
  return True    

import unittest

class TestSamerowcolumn(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(samerowcolumn([[1, 2, 3, 4], [2, 3, 4, 1], [3, 4, 1, 2], [4, 1, 2, 3]]), True, 'example 1')

  def test_ex2(self):
    self.assertEqual(samerowcolumn([[1]]), True, 'example 2')

  def test_ex3(self):
    self.assertEqual(samerowcolumn([[1, 2, 5], [5, 1, 2], [2, 5, 1]]), False, 'example 3')

  def test_ex4(self):
    self.assertEqual(samerowcolumn([[1, 2, 3], [1, 2, 3], [1, 2, 3]]), False, 'example 4')

  def test_ex5(self):
    self.assertEqual(samerowcolumn([[1, 2, 3], [3, 1, 2], [3, 2, 1]]), False, 'example 5')

unittest.main()
