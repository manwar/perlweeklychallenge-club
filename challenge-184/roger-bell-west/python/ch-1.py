#! /usr/bin/python3

import unittest

def sequencenumber(lst):
  nn = 0
  out = []
  for ins in lst:
    out.append("{:02d}".format(nn) + ins[2:6])
    nn += 1
  return out

class TestSequencenumber(unittest.TestCase):

        def test_ex1(self):
          self.assertEqual(sequencenumber(["ab1234", "cd5678", "ef1342"]),
                           ["001234", "015678", "021342"],
                           'example 1')

        def test_ex2(self):
          self.assertEqual(sequencenumber(["pq1122", "rs3334"]),
                           ["001122", "013334"],
                           'example 2')

unittest.main()
