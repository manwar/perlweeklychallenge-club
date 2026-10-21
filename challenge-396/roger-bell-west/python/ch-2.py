#! /usr/bin/python3

def trionicarray(a):
  state = 0
  prev = a[0]
  for i in range(1, len(a)):
    n = a[i]
    dir = 0
    if n > prev:
      dir = 1
    elif n < prev:
      dir = -1
    if dir == 0:
      return False
    match(state):
      case 0:
        if dir == 1:
          state = 1
        else:
          return False
      case 1:
        if dir == -1:
          state = 2
      case 2:
        if dir == 1:
          state = 3
      case 3:
        if dir == -1:
          return False
      case _:
        return False
    prev = n
  return state == 3

import unittest

class TestTrionicarray(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(trionicarray([1, 3, 5, 4, 2, 6, 8]), True, 'example 1')

  def test_ex2(self):
    self.assertEqual(trionicarray([1, 4, 4, 2, 1, 3, 5]), False, 'example 2')

  def test_ex3(self):
    self.assertEqual(trionicarray([2, 10, 3, 1, 9]), True, 'example 3')

  def test_ex4(self):
    self.assertEqual(trionicarray([1, 2, 3, 4, 3, 2, 1]), False, 'example 4')

  def test_ex5(self):
    self.assertEqual(trionicarray([1, 3, 2, 4, 1, 5, 2]), False, 'example 5')

unittest.main()
