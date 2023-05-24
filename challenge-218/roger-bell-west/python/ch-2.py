#! /usr/bin/python3

def matrixscore(matrix0):
  matrix = matrix0;
  for i in range(len(matrix)):
    if matrix[i][0] == 0:
      for j in range(len(matrix[i])):
        matrix[i][j] = 1 - matrix[i][j]
  t = len(matrix) // 2
  for i in range(1, len(matrix[0])):
    c = 0
    for j in range(len(matrix)):
      if matrix[j][i] == 0:
        c += 1
    if c > t:
      for j in range(len(matrix)):
        matrix[j][i] = 1 - matrix[j][i] 
  tot = 0
  for m in matrix:
    p = 0
    for n in m:
      p *= 2
      if n == 1:
        p += 1
    tot += p
  return tot

import unittest

class TestMatrixscore(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(matrixscore([[0, 0, 1, 1], [1, 0, 1, 0], [1, 1, 1, 0]]), 39, 'example 1')

  def test_ex2(self):
    self.assertEqual(matrixscore([[0]]), 1, 'example 2')

unittest.main()
