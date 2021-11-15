#! /usr/bin/python3

import unittest

from math import sqrt

def is_prime(n):
  if n>2 and n%2==0:
    return 0
  if n>3 and n%3==0:
    return 0
  lim=int(sqrt(n))
  k6=0
  while 1:
    k6+=6
    for t in [k6-1,k6+1]:
      if t <= lim:
        if n % t == 0:
          return False
      else:
        return True

def longprime(n):
  nn=n
  o=[]
  ba=[7]
  k6=6
  while nn>0:
    if len(ba)==0:
      k6+=6
      ba=[k6+1,k6-1]
    b=ba.pop()
    if is_prime(b):
      k=1
      l=0
      while 1:
        k*=10
        l+=1
        k %= b
        if k==1:
          break
      if l==b-1:
        o.append(b)
        nn-=1
  return o
      
class TestLongprime(unittest.TestCase):

        def test_ex1(self):
          self.assertEqual(longprime(5),[7, 17, 19, 23, 29],'example 1')

        def test_ex2(self):
          self.assertEqual(longprime(60),[7, 17, 19, 23, 29, 47, 59, 61, 97, 109, 113, 131, 149, 167, 179, 181, 193, 223, 229, 233, 257, 263, 269, 313, 337, 367, 379, 383, 389, 419, 433, 461, 487, 491, 499, 503, 509, 541, 571, 577, 593, 619, 647, 659, 701, 709, 727, 743, 811, 821, 823, 857, 863, 887, 937, 941, 953, 971, 977, 983],'example 1')

unittest.main()
