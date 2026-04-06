#! /usr/bin/python3

def parsetime(t):
  p = t.split(":")
  return int(p[0]) * 60 + int(p[1])

def conflictevents(a, b):
  r = []
  for t in (a, b):
    st = parsetime(t[0])
    en = parsetime(t[1])
    if st < en:
      r.append([[st, en - 1]])
    else:
      r.append([[st, 1440 - 1], [0, en - 1]])
  for ra in r[0]:
    for rb in r[1]:
      if ra[0] <= rb[1] and rb[0] <= ra[1]:
        return True
  return False

import unittest

class TestConflictevents(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(conflictevents(["10:00", "12:00"], ["11:00", "13:00"]), True, 'example 1')

  def test_ex2(self):
    self.assertEqual(conflictevents(["09:00", "10:30"], ["10:30", "12:00"]), False, 'example 2')

  def test_ex3(self):
    self.assertEqual(conflictevents(["14:00", "15:30"], ["14:30", "16:00"]), True, 'example 3')

  def test_ex4(self):
    self.assertEqual(conflictevents(["08:00", "09:00"], ["09:01", "10:00"]), False, 'example 4')

  def test_ex5(self):
    self.assertEqual(conflictevents(["23:30", "00:30"], ["00:00", "01:00"]), True, 'example 5')

unittest.main()
