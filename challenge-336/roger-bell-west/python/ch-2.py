#! /usr/bin/python3

def finalscore(a):
  p = []
  for n in a:
    match n:
      case "C":
        p.pop()
      case "D":
        p.append(2 * p[-1])
      case "+":
        p.append(p[-2] + p[-1])
      case _:
        p.append(int(n))
  return sum(p)

import unittest

class TestFinalscore(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(finalscore(["5", "2", "C", "D", "+"]), 30, 'example 1')

  def test_ex2(self):
    self.assertEqual(finalscore(["5", "-2", "4", "C", "D", "9", "+", "+"]), 27, 'example 2')

  def test_ex3(self):
    self.assertEqual(finalscore(["7", "D", "D", "C", "+", "3"]), 45, 'example 3')

  def test_ex4(self):
    self.assertEqual(finalscore(["-5", "-10", "+", "D", "C", "+"]), -55, 'example 4')

  def test_ex5(self):
    self.assertEqual(finalscore(["3", "6", "+", "D", "C", "8", "+", "D", "-2", "C", "+"]), 128, 'example 5')

unittest.main()
