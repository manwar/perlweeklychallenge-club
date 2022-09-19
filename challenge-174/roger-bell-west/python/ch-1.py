#! /usr/bin/python3

import unittest

def disarium(ct):
  o = []
  pows = [ [1] * 10 ]
  c = 0
  while True:
    disar = 0
    if c > 0:
      ca = c
      cl = []
      tx = 0
      while ca > 0:
        tx += 1
        cl.append(ca % 10)
        ca //= 10
      cl.reverse()
      if tx >= len(pows):
        for power in range(len(pows),tx+1):
          row = []
          for digit in range(10):
            row.append(pows[power-1][digit] * digit)
          pows.append(row)
      for (i, e) in enumerate(cl):
        disar += pows[i+1][e]
    if disar == c:
      o.append(c)
      if len(o) >= ct:
        break
    c += 1
  return o

class TestDisarium(unittest.TestCase):

        def test_ex1(self):
          self.assertEqual(disarium(19),
                           [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 89, 135,
                            175, 518, 598, 1306, 1676, 2427, 2646798],
                           'example 1')
 
unittest.main()
