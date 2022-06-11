#! /usr/bin/python3

import unittest

def ssd(n0):
  n = n0
  out = 0
  while n > 0:
    d = n % 10
    out += d * d
    n //= 10
  return out

def happy(ct):
  hm = {1: True}
  c = 0
  out = []
  while True:
    c += 1
    if not c in hm:
      v = c
      ss = set([v])
      h = True
      while True:
        if v in hm:
          h = hm[v]
          break
        else:
          v = ssd(v)
          if v in ss:
            h = False
            break
          ss.add(v)
      for i in ss:
        hm[i] = h
    if hm[c]:
      out.append(c)
      if len(out) >= ct:
        break
  return out

class TestHappy(unittest.TestCase):

        def test_ex1(self):
          self.assertEqual(happy(8),
                           [1, 7, 10, 13, 19, 23, 28, 31],
                           'example 1')

unittest.main()
