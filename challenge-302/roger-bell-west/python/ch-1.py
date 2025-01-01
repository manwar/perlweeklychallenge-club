#! /usr/bin/python3

def onesandzeroes(a, zeroes, ones):
  ax = []
  for ns in a:
    o = 0
    n = 0
    for c in ns:
      match c:
        case "0":
          o += 1
        case "1":
          n += 1
    ax.append((o, n))
  mx = 0
  for mask in range(1, 1 << len(ax)):
    o = 0
    n = 0
    ct = 0
    for i, x in enumerate(ax):
      if mask & (1 << i) > 0:
        o += x[0]
        n += x[1]
        ct += 1
        if o > zeroes or n > ones:
          break
      if o <= zeroes and n <= ones:
        mx = max([mx, ct])
  return mx

import unittest

class TestOnesandzeroes(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(onesandzeroes(["10", "0001", "111001", "1", "0"], 5, 3), 4, 'example 1')

  def test_ex2(self):
    self.assertEqual(onesandzeroes(["10", "1", "0"], 1, 1), 2, 'example 2')

unittest.main()
