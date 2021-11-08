#! /usr/bin/python3

import unittest

def ci(a):
  o=list()
  for i in range(1,len(a)):
    for j in range(i):
      if (a[i][0] >= a[j][0] and a[i][0] <= a[j][1]) or (a[i][1] >= a[j][0] and a[i][1] <= a[j][1]) or (a[i][0] <= a[j][0] and a[i][1] >= a[j][1]):
        o.append(a[i])
        break
  return o

class TestCi(unittest.TestCase):

        def test_ex1(self):
          self.assertEqual(ci([[1,4],[3,5],[6,8],[12,13],[3,20]]),[[3,5],[3,20]],'example 1')

        def test_ex2(self):
          self.assertEqual(ci([[3,4],[5,7],[6,9],[10,12],[13,15]]),[[6,9]],'example 2')
          
unittest.main()
