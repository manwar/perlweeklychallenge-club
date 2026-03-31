#! /usr/bin/python3

def validtimes(a):
  combinator = []
  for i, c in enumerate(a):
    if c.isdigit():
      combinator.append([int(c)])
    else:
      match i:
        case 0:
          combinator.append(list(range(2 + 1)))
        case 1 | 4:
          combinator.append(list(range(9 + 1)))
        case 3:
          combinator.append(list(range(5 + 1)))
  if len(combinator) != 4:
    return 0
  minutes = len(combinator[2]) * len(combinator[3])
  ct = 0
  for ax in combinator[0]:
    for bx in combinator[1]:
      if ax * 10 + bx <= 23:
        ct += 1
  return ct * minutes

import unittest

class TestValidtimes(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(validtimes("?2:34"), 3, 'example 1')

  def test_ex2(self):
    self.assertEqual(validtimes("?4:?0"), 12, 'example 2')

  def test_ex3(self):
    self.assertEqual(validtimes("??:??"), 1440, 'example 3')

  def test_ex4(self):
    self.assertEqual(validtimes("?3:45"), 3, 'example 4')

  def test_ex5(self):
    self.assertEqual(validtimes("2?:15"), 4, 'example 5')

unittest.main()
