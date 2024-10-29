#! /usr/bin/python3

def boomerang(a):
  delta = []
  # coincident points
  for ij in range(2):
    for ik in range(ij + 1, 3):
      if a[ij][0] == a[ik][0] and a[ij][1] == a[ik][1]:
        return False
    delta.append([a[ij + 1][0] - a[0][0], a[ij + 1][1] - a[0][1]])
  # all on the same vertical line
  if delta[0][0] == 0 and delta[1][0] == 0:
    return False
  # just one vertical line
  if delta[0][0] == 0 or delta[1][0] == 0:
    return True
  m = delta[0][1] / delta[0][0]
  c = a[0][1] - a[0][0] * m
  return a[2][1] != a[2][0] * m + c

import unittest

class TestBoomerang(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(boomerang([[1, 1], [2, 3], [3, 2]]), True, 'example 1')

  def test_ex2(self):
    self.assertEqual(boomerang([[1, 1], [2, 2], [3, 3]]), False, 'example 2')

  def test_ex3(self):
    self.assertEqual(boomerang([[1, 1], [1, 2], [2, 3]]), True, 'example 3')

  def test_ex4(self):
    self.assertEqual(boomerang([[1, 1], [1, 2], [1, 3]]), False, 'example 4')

  def test_ex5(self):
    self.assertEqual(boomerang([[1, 1], [2, 1], [3, 1]]), False, 'example 5')

  def test_ex6(self):
    self.assertEqual(boomerang([[0, 0], [2, 3], [4, 5]]), True, 'example 6')

unittest.main()
