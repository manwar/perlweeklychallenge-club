#! /usr/bin/python3

import unittest
import re

def equaldistribution(list):
  s = sum(list)
  if s % len(list) != 0:
    return -1
  m = s // len(list)
  out = 0
  w = list
  while True:
    for i in range(len(list)-1):
      if w[i] > m:
        v = w[i] - m
        w[i+1] += v
        out += v
        w[i] = m
      elif w[i] < m:
        v = min(m - w[i], w[i+1])
        w[i+1] -= v
        out += v
        w[i] += v
    done = True
    for v in w:
      if v != m:
        done = False
        break
    if done:
      break
  return out

class TestEqualdistribution(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(equaldistribution([1, 0, 5]), 4, "example 1")

  def test_ex2(self):
    self.assertEqual(equaldistribution([0, 2, 0]), -1, "example 2")

  def test_ex3(self):
    self.assertEqual(equaldistribution([0, 3, 0]), 2, "example 3")

unittest.main()
