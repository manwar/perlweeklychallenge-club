#! /usr/bin/python3

def reducedrowechelon(a):
  leadingone = []
  for row in a:
    lp = -1
    for cn, cell in enumerate(row):
      if cell == 1:
        lp = cn
        break
      elif cell != 0:
        return False
    leadingone.append(lp)
  while leadingone[-1] == -1:
    leadingone.pop()
  c = leadingone.copy()
  c.sort()
  if c[0] == -1:
    return False
  if c != leadingone:
    return False
  for i in c:
    col = [r[i] for r in a]
    col.sort()
    if col[-1] != 1 or col[-2] != 0 or col[0] != 0:
      return False
  return True

import unittest

class TestReducedrowechelon(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(reducedrowechelon([[1, 1, 0], [0, 1, 0], [0, 0, 0]]), False, 'example 1')

  def test_ex2(self):
    self.assertEqual(reducedrowechelon([[0, 1, -2, 0, 1], [0, 0, 0, 1, 3], [0, 0, 0, 0, 0], [0, 0, 0, 0, 0]]), True, 'example 2')

  def test_ex3(self):
    self.assertEqual(reducedrowechelon([[1, 0, 0, 4], [0, 1, 0, 7], [0, 0, 1, -1]]), True, 'example 3')

  def test_ex4(self):
    self.assertEqual(reducedrowechelon([[0, 1, -2, 0, 1], [0, 0, 0, 0, 0], [0, 0, 0, 1, 3], [0, 0, 0, 0, 0]]), False, 'example 4')

  def test_ex5(self):
    self.assertEqual(reducedrowechelon([[0, 1, 0], [0, 1, 0], [0, 0, 0]]), False, 'example 5')

  def test_ex6(self):
    self.assertEqual(reducedrowechelon([[4, 0, 0, 0], [0, 1, 0, 7], [0, 0, 1, -1]]), False, 'example 6')

  def test_ex7(self):
    self.assertEqual(reducedrowechelon([[1, 0, 0, 4], [1, 0, 0, 7], [0, 0, 1, -1]]), False, 'example 7')

  def test_ex8(self):
    self.assertEqual(reducedrowechelon([[1, -2, 0, 4], [0, 1, 0, 7], [0, 0, 1, -1]]), False, 'example 8')

unittest.main()
