#! /usr/bin/python3

def percentageofcharacter(a, c):
  d = len(a)
  n = 100 * a.count(c)
  return (n + d // 2) // d

import unittest

class TestPercentageofcharacter(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(percentageofcharacter("perl", "e"), 25, 'example 1')

  def test_ex2(self):
    self.assertEqual(percentageofcharacter("java", "a"), 50, 'example 2')

  def test_ex3(self):
    self.assertEqual(percentageofcharacter("python", "m"), 0, 'example 3')

  def test_ex4(self):
    self.assertEqual(percentageofcharacter("ada", "a"), 67, 'example 4')

  def test_ex5(self):
    self.assertEqual(percentageofcharacter("ballerina", "l"), 22, 'example 5')

  def test_ex6(self):
    self.assertEqual(percentageofcharacter("analitik", "k"), 13, 'example 6')

unittest.main()
