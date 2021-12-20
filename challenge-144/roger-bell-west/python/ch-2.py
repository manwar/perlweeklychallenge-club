#! /usr/bin/python3

import unittest

def ulam(u,v,count):
  ulams=[u,v]
  sieve=[]
  uc=v
  while len(ulams) < count:
    sieve.extend([0] * (uc+ulams[-2]-len(sieve)))
    for i in range(len(ulams)-1):
      sieve[uc + ulams[i] - 1] += 1
    for i in range(uc,len(sieve)):
      if sieve[i]==1:
        uc=i+1
        ulams.append(uc)
        break
  return ulams

class TestUlam(unittest.TestCase):

        def test_ex1(self):
          self.assertEqual(ulam(1,2,10),[1, 2, 3, 4,  6 , 8, 11, 13, 16, 18],'example 1')

        def test_ex2(self):
          self.assertEqual(ulam(2,3,10),[2, 3, 5, 7,  8,  9, 13, 14, 18, 19],'example 2')

        def test_ex3(self):
          self.assertEqual(ulam(2,5,10),[2, 5, 7, 9, 11, 12, 13, 15, 19, 23],'example 3')

unittest.main()
