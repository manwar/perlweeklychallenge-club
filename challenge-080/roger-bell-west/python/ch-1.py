#! /usr/bin/python3

import unittest

def spn(list):
    r=frozenset(list)
    m=1
    while m in r:
        m += 1
    return m

class TestSpn(unittest.TestCase):

    def test_ex1(self):
        self.assertEqual(spn((5,2,-2,0)),1,'example 1')

    def test_ex2(self):
        self.assertEqual(spn((1,8,-1)),2,'example 2')

    def test_ex3(self):
        self.assertEqual(spn((2,0,-1)),1,'example 3')

unittest.main()
