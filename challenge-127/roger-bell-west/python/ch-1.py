#! /usr/bin/python3

import unittest

def ds(a,b):
  sa=set(a)
  sb=set(b)
  inter=sa.intersection(sb)
  if len(inter)==0:
    return 1
  else:
    return 0

class TestDs(unittest.TestCase):

        def test_ex1(self):
          self.assertEqual(ds([1,2,5,3,4],[4,6,7,8,9]),0,'example 1')

        def test_ex2(self):
          self.assertEqual(ds([1,3,5,7,9],[0,2,4,6,8]),1,'example 2')
          
unittest.main()
