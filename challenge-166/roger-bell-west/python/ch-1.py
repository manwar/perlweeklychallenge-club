#! /usr/bin/python3

import unittest

from collections import defaultdict
from functools import reduce
from itertools import product
import operator

def hexwords(lo,hi,sb):
  out = []
  fh = open('dictionary.txt','r')
  for ll in fh:
    line = ll.rstrip()
    if len(line) >= lo and len(line) <= hi:
      valid = True
      sbc = 0
      for c in line:
        if c == 'o' or c == 'i' or c == 'l' or c == 's' or c == 't':
          sbc += 1
          if sbc > sb:
            valid = False
        elif c < 'a' or c > 'f':
          valid = False
        if not valid:
          break
      if valid:
        out.append(line)
  fh.close()
  return out

def combiwords(wl,l):
  wh = defaultdict(list)
  for w in wl:
    wh[len(w)].append(w)
  tmap = [[]]
  omap = []
  while len(tmap) > 0:
    c = tmap.pop()
    s = reduce(operator.add,c,0)
    for j in range(1,l-s):
      if j in wh:
        cc = c.copy()
        cc.append(j)
        tmap.append(cc)
    if l-s in wh:
      c.append(l-s)
      omap.append(c)
  out = []
  for pat in omap:
    for wx in product(*[wh[x] for x in pat]):
      out.append("".join(wx))
  return out

class TestHexwords(unittest.TestCase):

        def test_ex1(self):
          self.assertEqual(len(hexwords(2,8,8)),
                           1463,
                           'example 1')

        def test_ex2(self):
          self.assertEqual(len(hexwords(8,8,8)),
                           164,
                           'example 2')

        def test_ex3(self):
          self.assertEqual(len(hexwords(2,8,0)),
                           45,
                           'example 3')

        def test_ex4(self):
          self.assertEqual(len(hexwords(2,8,1)),
                           244,
                           'example 4')

        def test_ex5(self):
          self.assertEqual(len(combiwords(hexwords(4,4,0),8)),
                           144,
                           'example 5')

        def test_ex6(self):
          self.assertEqual(len(combiwords(hexwords(3,5,0),8)),
                           274,
                           'example 6')

unittest.main()
