#! /usr/bin/python3

import unittest

def sparkline(nn):
  bar = [chr(bc) for bc in range(9601, 9608+1)]
  mn = min(nn)
  mx = max(nn)
  inscale = mx - mn
  outscale = len(bar)
  return ''.join(bar[min(int((n-mn) / inscale * outscale),outscale - 1)] for n in nn)

class TestSparkline(unittest.TestCase):

        def test_ex1(self):
          self.assertEqual(sparkline([0, 100]),
                           "▁█", 'example 1')

        def test_ex2(self):
          self.assertEqual(sparkline([1, 2, 3, 4, 5, 6, 7, 8]),
                           "▁▂▃▄▅▆▇█", 'example 2')

unittest.main()
