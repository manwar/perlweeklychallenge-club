#! /usr/bin/python3

import unittest

from math import floor

def eban(mx):
  units=[True,False,True,False,True,False,True,False,False,False]
  tens=[True,False,False,True,True,True,True,False,False,False,False]
  out=[]
  for i in range(mx+1):
    if tens[floor(i/10)] and units[i%10] and i!=0:
      out.append(i)
  return out

class TestEban(unittest.TestCase):

        def test_ex1(self):
          self.assertEqual(eban(100),[2, 4, 6, 30, 32, 34, 36, 40, 42, 44, 46, 50, 52, 54, 56, 60, 62, 64, 66],'example 1')

unittest.main()
