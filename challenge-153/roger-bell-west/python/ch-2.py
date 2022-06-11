#! /usr/bin/python3

import unittest

def factorion(input:int):
  if input==0:
    return False
  fd=[1]
  ff=1
  for i in range(1,10):
    ff *= i
    fd.append(ff)
  working=input
  dsum=0
  while working>0:
    (working,d)=divmod(working,10)
    dsum += fd[d]
  return input==dsum

class TestFactorion(unittest.TestCase):

        def test_ex1(self):
          self.assertEqual(factorion(145),True,'example 1')

        def test_ex2(self):
          self.assertEqual(factorion(125),False,'example 2')

unittest.main()
