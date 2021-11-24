#! /usr/bin/python3

import unittest

def cvradix(n,r,tf):
  o=0
  nn=n
  m=1
  if tf==0:
    ra=r
    rb=10
  else:
    ra=10
    rb=r
  while nn>0:
    o+=(nn % ra) * m
    nn=int(nn/ra)
    m*=rb
  return o

def dcbadd(a,b):
  return cvradix(cvradix(a,2,1)+cvradix(b,2,1),2,0)

class TestDcbadd(unittest.TestCase):

        def test_ex1(self):
          self.assertEqual(dcbadd(11,1),100,'example 1')

        def test_ex2(self):
          self.assertEqual(dcbadd(101,1),110,'example 2')

        def test_ex3(self):
          self.assertEqual(dcbadd(100,11),111,'example 3')

unittest.main()
