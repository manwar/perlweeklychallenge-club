#! /usr/bin/python3

from math import sqrt,log

def pti(n):
    l=log(n)
    for ca in range(2,int(sqrt(n))+1):
        bg=int(l/log(ca))
        for cb in range(bg,bg+2):
            if ca ** cb == n:
                return 1
    return 0

import unittest

class TestPti(unittest.TestCase):

    def test_ex1(self):
        self.assertEqual(pti(8),1,'example 1')

    def test_ex2(self):
        self.assertEqual(pti(15),0,'example 2')

    def test_ex3(self):
        self.assertEqual(pti(125),1,'example 3')

unittest.main()
