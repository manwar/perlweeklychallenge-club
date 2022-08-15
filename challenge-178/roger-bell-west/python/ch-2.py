#! /usr/bin/python3

import unittest

from datetime import datetime, timedelta

def addbizhours(start, delta):
  current = datetime.fromisoformat(start)
  seconds = 3600 * delta
  bizdaylength = 3600 * 9
  if not isbiz(current):
    current = nextbizstart(current)
  ed = nextbizend(current)
  remain = (ed - current).total_seconds()
  if remain < seconds:
    seconds -= remain
    current = nextbizstart(ed)
    while seconds > bizdaylength:
      current = nextbizstart(current)
      seconds -= bizdaylength
  current += timedelta(seconds = seconds)
  return current.strftime("%Y-%m-%d %H:%M")

def isbiz(tm):
  if tm.weekday() > 4:
    return False
  if tm.hour < 9 or tm.hour >= 18:
    return False
  return True

def nextbizstart(tm0):
  tm = tm0
  while tm.weekday() > 4:
    tm += timedelta(days = 1)
    tm = tm.replace(hour = 9, minute = 0, second = 0)
  if tm.hour < 9:
    tm = tm.replace(hour = 9, minute = 0, second = 0)
  else:
    while True:
      tm += timedelta(days = 1)
      tm = tm.replace(hour = 9, minute = 0, second = 0)
      if tm.weekday() < 5:
        break
  return tm

def nextbizend(tm0):
  tm = tm0
  while tm.weekday() > 4:
    tm += timedelta(days = 1)
    tm = tm.replace(hour = 18, minute = 0, second = 0)
  if tm.hour >= 18:
    while True:
      tm += timedelta(days = 1)
      tm = tm.replace(hour = 18, minute = 0, second = 0)
      if tm.weekday() < 5:
        break
  else:
    tm = tm.replace(hour = 18, minute = 0, second = 0)
  return tm

class TestAddBizHours(unittest.TestCase):

        def test_ex1(self):
          self.assertEqual(addbizhours("2022-08-01 10:30", 4.0),
                           "2022-08-01 14:30", 'example 1')

        def test_ex2(self):
          self.assertEqual(addbizhours("2022-08-01 17:00", 3.5),
                           "2022-08-02 11:30", 'example 2')

        def test_ex3(self):
          self.assertEqual(addbizhours("2022-08-01 18:00", 3.5),
                           "2022-08-02 12:30", 'example 3')

        def test_ex4(self):
          self.assertEqual(addbizhours("2022-08-01 19:00", 3.5),
                           "2022-08-02 12:30", 'example 4')

        def test_ex5(self):
          self.assertEqual(addbizhours("2022-08-05 17:00", 3.5),
                           "2022-08-08 11:30", 'example 5')

        def test_ex6(self):
          self.assertEqual(addbizhours("2022-08-01 12:00",18.0),
                           "2022-08-03 12:00", 'example 6')



unittest.main()
