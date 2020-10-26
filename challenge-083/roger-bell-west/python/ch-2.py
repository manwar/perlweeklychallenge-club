#! /usr/bin/python3

from itertools import combinations
import unittest

def fa(*a):
    ss=sum(a)
    ls=ss
    li=0
    for inv in range(1,len(a)):
        for l in combinations(a,inv):
            s=ss-2*sum(l)
            if (s >= 0):
                if (ls == ss or s < ls or (s == ls and inv < li)):
                    ls=s
                    li=inv
    return li

class TestFa(unittest.TestCase):

    def test_ex1(self):
        self.assertEqual(fa(3,10,8),1,'example 1')

    def test_ex2(self):
        self.assertEqual(fa(12,2,10),1,'example 2')

    def test_ex3(self):
        self.assertEqual(fa(2,2,10),2,'example 3')

unittest.main()
