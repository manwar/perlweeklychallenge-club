#! /usr/bin/python3

import unittest

def rbt(ti):
  s=0
  for n in ti:
    if n>0:
      s += n
  to=list()
  for n in ti:
    if n>0:
      to.append(s-n)
    else:
      to.append(n)
  return to

class TestRbt(unittest.TestCase):

        def test_ex1(self):
          self.assertEqual(rbt([1,2,3,4,-1,5,6,-1,7]),[27,26,25,24,-1,23,22,-1,21],'example 1')

unittest.main()
