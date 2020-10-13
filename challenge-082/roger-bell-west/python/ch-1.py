#! /usr/bin/python3

import unittest
from math import sqrt

def factor(n):
    o=set()
    o.add(1)
    o.add(n)
    for i in range(2,int(sqrt(n))+1):
        if (n % i == 0):
          o.add(int(n/i))
          o.add(i)
    return o

def commonfactor(*fs):
    f=list(map(factor,fs))
    s=f.pop();
    while (f):
        s = s & f.pop()
    return sorted(s)

class TestCf(unittest.TestCase):

    def test_f1(self):
        self.assertEqual(factor(12),set((1,2,3,4,6,12)),'twelve')

    def test_f2(self):
        self.assertEqual(factor(18),set((1,2,3,6,9,18)),'eighteen')

    def test_f3(self):
        self.assertEqual(factor(23),set((1,23)),'twenty-three')

    def test_cf1(self):
        self.assertEqual(commonfactor(12,18),[1,2,3,6],'twelve-eighteen')

    def test_cf2(self):
        self.assertEqual(commonfactor(18,23),[1],'twelve-twentythree')

unittest.main()
