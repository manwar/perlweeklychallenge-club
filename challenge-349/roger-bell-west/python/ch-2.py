#! /usr/bin/python3

from collections import defaultdict

def counterify(a):
  s = defaultdict(lambda: 0)
  for n in a:
    s[n] += 1
  return s

def meetingpoint(a):
  c = counterify(a)
  return c["U"] == c["D"] and c["L"] == c["R"]

import unittest

class TestMeetingpoint(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(meetingpoint("ULD"), False, 'example 1')

  def test_ex2(self):
    self.assertEqual(meetingpoint("ULDR"), True, 'example 2')

  def test_ex3(self):
    self.assertEqual(meetingpoint("UUURRRDDD"), False, 'example 3')

  def test_ex4(self):
    self.assertEqual(meetingpoint("UURRRDDLLL"), True, 'example 4')

  def test_ex5(self):
    self.assertEqual(meetingpoint("RRUULLDDRRUU"), False, 'example 5')

unittest.main()
