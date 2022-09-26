#! /usr/bin/python3

import unittest

def splitarray(lst):
  out = [ [], [] ]
  for ins in lst:
    av = []
    bv = []
    for c in ins:
      if c >= "0" and c <= "9":
        av.append(int(c))
      elif c >= "a" and c <= "z":
        bv.append(c)
    if len(av) > 0:
      out[0].append(av)
    if len(bv) > 0:
      out[1].append(bv)
  return out

class TestSplitarray(unittest.TestCase):

        def test_ex1(self):
          self.assertEqual(splitarray(["a 1 2 b 0", "3 c 4 d"]),
                           [ [[1, 2, 0], [3, 4]],
                             [['a', 'b'], ['c', 'd']] ],
                           'example 1')

        def test_ex2(self):
          self.assertEqual(splitarray(["1 2", "p q r", "s 3", "4 5 t"]),
                           [ [[1, 2], [3], [4, 5]],
                             [['p', 'q', 'r'], ['s'], ['t']] ],
                           'example 2')

unittest.main()
