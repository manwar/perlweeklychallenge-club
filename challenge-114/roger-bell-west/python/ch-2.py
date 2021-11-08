#! /usr/bin/python3

import unittest
import re

def hisb(n):
  s="0" + "{0:b}".format(n)
  p=re.compile(r"^(.*?)01(1*0*)$")
  m=p.match(s)
  a=m.group(1)
  c=m.group(2)
  t0=c.replace("1","")
  t1=c.replace("0","")
  return int(a + "10" + t0 + t1,2)

class TestHisb(unittest.TestCase):

        def test_ex1(self):
          self.assertEqual(hisb(3),5,'example 1')
          
        def test_ex2(self):
          self.assertEqual(hisb(12),17,'example 2')

unittest.main()
