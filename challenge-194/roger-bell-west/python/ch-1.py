#! /usr/bin/python3

import unittest

def digitalclock(hhmm):
  i = hhmm.find("?")
  if i == 0:
    if hhmm[1] <= "3":
      return 2
    return 1
  elif i == 1:
    if hhmm[0] < "2":
      return 9
    return 3
  elif i == 3:
    return 5
  elif i == 4:
    return 9
  return 0

class TestDigitalclock(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(digitalclock("?5:00"), 1, 'example 1')

  def test_ex2(self):
    self.assertEqual(digitalclock("?3:00"), 2, 'example 2')

  def test_ex3(self):
    self.assertEqual(digitalclock("1?:00"), 9, 'example 3')

  def test_ex4(self):
    self.assertEqual(digitalclock("2?:00"), 3, 'example 4')

  def test_ex5(self):
    self.assertEqual(digitalclock("12:?5"), 5, 'example 5')

  def test_ex6(self):
    self.assertEqual(digitalclock("12:5?"), 9, 'example 6')

unittest.main()
