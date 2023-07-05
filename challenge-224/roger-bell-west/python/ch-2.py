#! /usr/bin/python3

def exdigits(digits, start, end):
  x = 0
  for i in range(start, end + 1):
    x *= 10
    x += digits[i]
  return x

def additivenumber(digitstring):
  digits = [int(x) for x in digitstring]
  stack = []
  for i in range(len(digits) - 2):
    for j in range(i + 1, len(digits) - 1):
      stack.append((0, i, j))
  while len(stack) > 0:
    start_a, end_a, end_b = stack.pop()
    start_b = end_a + 1
    val_ab = exdigits(digits, start_a, end_a) + exdigits(digits, start_b, end_b)
    start_c = end_b + 1
    for end_c in range(start_c, len(digits)):
      if val_ab == exdigits(digits, start_c, end_c):
        if end_c == len(digits) - 1:
          return True
        else:
          stack.append((start_b, end_b, end_c))
          break
  return False

import unittest

class TestAdditivenumber(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(additivenumber("112358"), True, 'example 1')

  def test_ex2(self):
    self.assertEqual(additivenumber("12345"), False, 'example 2')

  def test_ex3(self):
    self.assertEqual(additivenumber("199100199"), True, 'example 3')

unittest.main()
