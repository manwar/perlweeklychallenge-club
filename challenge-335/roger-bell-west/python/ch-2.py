#! /usr/bin/python3

def findwinner(a):
  board = [ [ 0, 0, 0], [ 0, 0, 0], [ 0, 0, 0] ]
  player = 1
  for play in a:
    board[play[0]][play[1]] = player
    player = 3 - player
  for pattern in [
      [0, 0, 1, 0],
      [0, 1, 1, 0],
      [0, 2, 1, 0],
      [0, 0, 0, 1],
      [1, 0, 0, 1],
      [2, 0, 0, 1],
      [0, 0, 1, 1],
      [0, 2, 1, -1] ]:
    cellvals = set()
    for i in range(3):
      x = pattern[0] + i * pattern[2]
      y = pattern[1] + i * pattern[3]
      cellvals.add(board[y][x])
    if len(cellvals) == 1:
      winner = list(cellvals)[0]
      if winner == 1:
        return "A"
      elif winner == 2:
        return "B"
  if len(a) == 9:
    return "Draw"
  else:
    return "Pending"

import unittest

class TestFindwinner(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(findwinner([[0, 0], [2, 0], [1, 1], [2, 1], [2, 2]]), "A", 'example 1')

  def test_ex2(self):
    self.assertEqual(findwinner([[0, 0], [1, 1], [0, 1], [0, 2], [1, 0], [2, 0]]), "B", 'example 2')

  def test_ex3(self):
    self.assertEqual(findwinner([[0, 0], [1, 1], [2, 0], [1, 0], [1, 2], [2, 1], [0, 1], [0, 2], [2, 2]]), "Draw", 'example 3')

  def test_ex4(self):
    self.assertEqual(findwinner([[0, 0], [1, 1]]), "Pending", 'example 4')

  def test_ex5(self):
    self.assertEqual(findwinner([[1, 1], [0, 0], [2, 2], [0, 1], [1, 0], [0, 2]]), "B", 'example 5')

unittest.main()
