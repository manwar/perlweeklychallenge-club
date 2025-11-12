#! /usr/bin/python3

def formatdate(a):
  dmy = a.split(" ")
  out = []
  out.append(int(dmy[2]))
  out.append({
        "Jan": 1,
        "Feb": 2,
        "Mar": 3,
        "Apr": 4,
        "May": 5,
        "Jun": 6,
        "Jul": 7,
        "Aug": 8,
        "Sep": 9,
        "Oct": 10,
        "Nov": 11,
        "Dec": 12,
    }[dmy[1]])
  if dmy[0][1] >= "0" and dmy[0][1] <= "9":
    out.append(int(dmy[0][0:2]))
  else:
    out.append(int(dmy[0][0:1]))
  return "{:04d}-{:02d}-{:02d}".format(*out)

import unittest

class TestFormatdate(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(formatdate("1st Jan 2025"), "2025-01-01", 'example 1')

  def test_ex2(self):
    self.assertEqual(formatdate("22nd Feb 2025"), "2025-02-22", 'example 2')

  def test_ex3(self):
    self.assertEqual(formatdate("15th Apr 2025"), "2025-04-15", 'example 3')

  def test_ex4(self):
    self.assertEqual(formatdate("23rd Oct 2025"), "2025-10-23", 'example 4')

  def test_ex5(self):
    self.assertEqual(formatdate("31st Dec 2025"), "2025-12-31", 'example 5')

unittest.main()
