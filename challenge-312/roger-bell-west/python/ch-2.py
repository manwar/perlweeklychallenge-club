#! /usr/bin/python3

def ballsandboxes(a):
  boxes = dict()
  colout = "@"
  for i, c in enumerate(a):
    if i % 2 == 0:
      colour = c
    else:
      boxid = int(c)
      s = set()
      if boxid in boxes:
        s = boxes[boxid]
      s.add(colour)
      boxes[boxid] = s
  return len([x for x in boxes.values() if len(x) >= 3])

import unittest

class TestBallsandboxes(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(ballsandboxes("G0B1R2R0B0"), 1, 'example 1')

  def test_ex2(self):
    self.assertEqual(ballsandboxes("G1R3R6B3G6B1B6R1G3"), 3, 'example 2')

  def test_ex3(self):
    self.assertEqual(ballsandboxes("B3B2G1B3"), 0, 'example 3')

unittest.main()
