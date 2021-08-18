#! /usr/bin/python3

import unittest

def cn(n):
  k=n
  digits=[]
  while k>0:
    d=k % 10
    if d==1:
      digits=[8] * len(digits)
    if d>0:
      d -= 1
    digits.append(d)
    k=int(k/10)
  tc=0
  for i in range(len(digits)-1,-1,-1):
    tc *= 9
    tc += digits[i]
  return tc

class TestCn(unittest.TestCase):

        def test_ex1(self):
          self.assertEqual(cn(15),8,'example 1')

        def test_ex2(self):
          self.assertEqual(cn(25),13,'example 2')

        def test_ex3(self):
          self.assertEqual(cn(10000),6560,'example 3')

        def test_ex4(self):
          self.assertEqual(cn(100000000),43046720,'example 3')
          
unittest.main()
