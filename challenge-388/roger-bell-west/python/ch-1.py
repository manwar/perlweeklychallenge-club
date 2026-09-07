#! /usr/bin/python3

from collections import deque

def dyckwords(order):
  out = []
  queue = deque([""])
  while len(queue) > 0:
    st = queue.popleft()
    dcount = len([x for x in st if x == "D"])
    if len(st) == order * 2:
      if dcount == order:
        out.append(st)
    else:
      if dcount * 2 < len(st):
        queue.append(st + "D")
      queue.append(st + "U")
  return out

import unittest

class TestDyckwords(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(dyckwords(1), ["UD"], 'example 1')

  def test_ex2(self):
    self.assertEqual(dyckwords(2), ["UDUD", "UUDD"], 'example 2')

  def test_ex3(self):
    self.assertEqual(dyckwords(3), ["UDUDUD", "UDUUDD", "UUDDUD", "UUDUDD", "UUUDDD"], 'example 3')

  def test_ex4(self):
    self.assertEqual(dyckwords(0), [""], 'example 4')

  def test_ex5(self):
    self.assertEqual(dyckwords(4), ["UDUDUDUD", "UDUDUUDD", "UDUUDDUD", "UDUUDUDD", "UDUUUDDD", "UUDDUDUD", "UUDDUUDD", "UUDUDDUD", "UUDUDUDD", "UUDUUDDD", "UUUDDDUD", "UUUDDUDD", "UUUDUDDD", "UUUUDDDD"], 'example 5')

unittest.main()
