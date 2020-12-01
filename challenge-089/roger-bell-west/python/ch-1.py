#! /usr/bin/python3

from math import gcd

def gs(n):
    tot=n-1;
    for a in range(2,n):
        tot += sum(gcd(a,x) for x in range(a+1,n+1))
    return tot

import unittest

class TestGs(unittest.TestCase):

    def test_ex1(self):
        self.assertEqual(gs(3),3,'example 1')

    def test_ex2(self):
        self.assertEqual(gs(4),7,'example 2')

unittest.main()
