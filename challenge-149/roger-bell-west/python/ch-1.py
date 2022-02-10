#! /usr/bin/python3

import unittest

from math import floor

def fds(n):
  o=[]
  f=[1,0]
  ft=set(f)
  k=0
  while len(o) < n:
    ds=0
    j=k
    while (j > 0):
      ds += j % 10
      j //= 10
    while f[0] < ds:
      t=f[1]+f[0]
      f[1]=f[0]
      f[0]=t
      ft.add(f[0])
    if ds in ft:
      o.append(k)
    k += 1
  return o

class TestFds(unittest.TestCase):

        def test_ex1(self):
          self.assertEqual(fds(8),[0, 1, 2, 3, 5, 8, 10, 11],'example 1')

        def test_ex2(self):
          self.assertEqual(fds(20),[0, 1, 2, 3, 5, 8, 10, 11, 12, 14, 17, 20, 21, 23, 26, 30, 32, 35, 41, 44],'example 2')

        def test_ex3(self):
          self.assertEqual(fds(61),[0, 1, 2, 3, 5, 8, 10, 11, 12, 14, 17, 20, 21, 23, 26, 30, 32, 35, 41, 44, 49, 50, 53, 58, 62, 67, 71, 76, 80, 85, 94, 100, 101, 102, 104, 107, 110, 111, 113, 116, 120, 122, 125, 131, 134, 139, 140, 143, 148, 152, 157, 161, 166, 170, 175, 184, 193, 200, 201, 203, 206],'example 3')

unittest.main()
