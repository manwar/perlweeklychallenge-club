#! /usr/bin/python3

from functools import reduce

def championteam(a):
  maxw = 0
  teamw = []
  for i, w in enumerate(a):
    wins = reduce(lambda x, y: x + y, w)
    if wins > maxw:
      teamw = []
      maxw = wins
    if wins == maxw:
      teamw.append(i)
  if len(teamw) == 1:
    return teamw[0]
  bestt = teamw[0]
  for rt in teamw:
    if a[rt][bestt] == 1:
      beastt = rt
  return bestt


import unittest

class TestChampionteam(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(championteam([[0, 1, 1], [0, 0, 1], [0, 0, 0]]), 0, 'example 1')

  def test_ex2(self):
    self.assertEqual(championteam([[0, 1, 0, 0], [0, 0, 0, 0], [1, 1, 0, 0], [1, 1, 1, 0]]), 3, 'example 2')

  def test_ex3(self):
    self.assertEqual(championteam([[0, 1, 0, 1], [0, 0, 1, 1], [1, 0, 0, 0], [0, 0, 1, 0]]), 0, 'example 3')

  def test_ex4(self):
    self.assertEqual(championteam([[0, 1, 1], [0, 0, 0], [0, 1, 0]]), 0, 'example 4')

  def test_ex5(self):
    self.assertEqual(championteam([[0, 0, 0, 0, 0], [1, 0, 0, 0, 0], [1, 1, 0, 1, 1], [1, 1, 0, 0, 0], [1, 1, 0, 1, 0]]), 2, 'example 5')

unittest.main()
