#! /usr/bin/python3

import unittest

def r2qi(n):
  return c2qi(n, 0)

def c2qi(r0, i0):
  l = []
  for n0 in [i0, r0]:
    n = n0
    digits = []
    while n != 0:
      digit = n % -4
      n //= -4
      if digit < 0:
        digit += 4
        n += 1
      digits.append(digit)
    l.append(digits)
  ld = len(l[0]) - len(l[1])
  if ld < 0:
    l[0] = ([0] * (-ld-1)) + l[0]
  elif ld > 1:
    l[1] = ([0] * ld) + l[1]
  o = ""
  for i in reversed(range(len(l[1]))):
    for b in range(2):
      if len(l[b]) > i:
        o += str(l[b][i])
  return o

def qi2r(n):
  return qi2c(n)[0]

def qi2c(n):
  pow = 1
  ri = 0
  o = [0, 0]
  for ch in n[::-1]:
    o[ri] += int(ch) * pow
    ri += 1
    pow *= 2
    if ri == 2:
      ri = 0
      pow = -pow
  return o

class TestQi(unittest.TestCase):

        def test_ex1(self):
          self.assertEqual(r2qi(4), "10300", 'example 1')

        def test_ex2(self):
          self.assertEqual(qi2r("10300"), 4, 'example 2')

unittest.main()
