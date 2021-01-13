#! /usr/bin/python3

def jg(n):
    mx=len(n)-1
    p=0
    while (True):
        p += n[p]
        if p == mx:
            return 1
        elif p > mx or n[p]==0:
            return 0

import unittest

class TestJg(unittest.TestCase):

    def test_ex1(self):
        self.assertEqual(jg([1,2,1,2]),1,'example 1');

    def test_ex2(self):
        self.assertEqual(jg([2,1,1,0,2]),0,'example 2');

unittest.main()
