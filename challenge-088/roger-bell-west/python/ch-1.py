#! /usr/bin/python3

from functools import reduce
import operator

def aop(ns):
    p=reduce(operator.mul,ns)
    return [p // i for i in ns]

import unittest;

class TestAop(unittest.TestCase):

    def test_ex1(self):
        self.assertEqual(aop((5, 2, 1, 4, 3)),[24, 60, 120, 30, 40],'example 1')

    def test_ex2(self):
        self.assertEqual(aop((2, 1, 4, 3)),[12, 24, 6, 8],'example 2')

unittest.main()
