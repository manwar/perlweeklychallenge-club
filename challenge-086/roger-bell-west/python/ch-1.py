#! /usr/bin/python3

def pti(n,a):
    ns=set(n)
    for x in n:
        if x+a in ns:
            return 1
    return 0

import unittest

class TestPti(unittest.TestCase):

    def test_ex1(self):
        self.assertEqual(pti((10, 8, 12, 15, 5),7),1,'example 1')

    def test_ex2(self):
        self.assertEqual(pti((1, 5, 2, 9, 7),6),1,'example 2')

    def test_ex3(self):
        self.assertEqual(pti((10, 30, 20, 50, 40),15),0,'example 3')

unittest.main()
