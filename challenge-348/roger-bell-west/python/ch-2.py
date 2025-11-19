#! /usr/bin/python3

def hm2m(a):
  p = a.split(":")
  return int(p[0]) * 60 + int(p[1])

def converttime(ssrc, ttgt):
  src = hm2m(ssrc)
  tgt = hm2m(ttgt)
  if tgt < src:
    tgt += 24 * 60
  delta = tgt - src
  oc = 0
  for op in [60, 15, 5, 1]:
    oc += delta // op
    delta %= op
  return oc

import unittest

class TestConverttime(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(converttime("02:30", "02:45"), 1, 'example 1')

  def test_ex2(self):
    self.assertEqual(converttime("11:55", "12:15"), 2, 'example 2')

  def test_ex3(self):
    self.assertEqual(converttime("09:00", "13:00"), 4, 'example 3')

  def test_ex4(self):
    self.assertEqual(converttime("23:45", "00:30"), 3, 'example 4')

  def test_ex5(self):
    self.assertEqual(converttime("14:20", "15:25"), 2, 'example 5')

unittest.main()
