#! /usr/bin/python3

import unittest
import re

def ri(n,d):
  dd=re.compile(".*"+str(d)+".*")
  e=[i for i in range(1,n+1) if re.match(dd,str(i))]
  for i in range(1,1<<len(e)):
    s=0
    for ii in range(len(e)):
      if 1<<ii & i:
        s += e[ii]
    if s==n:
      return 1
  return 0

class TestRi(unittest.TestCase):

        def test_ex1(self):
          self.assertEqual(ri(25,7),0,'example 1')
          
        def test_ex2(self):
          self.assertEqual(ri(24,7),1,'example 2')
          

unittest.main()
