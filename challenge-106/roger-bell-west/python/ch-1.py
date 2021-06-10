#! /usr/bin/python3

def mg(*aa):
    a=list(aa)
    a.sort()
    g=0
    for i in range(len(a)-1):
        d=abs(a[i]-a[i+1])
        if d>g:
            g=d
    return g

import unittest

class TestMg(unittest.TestCase):

        def test_ex1(self):
            self.assertEqual(mg(2,9,3,5),4,'example 1')

        def test_ex2(self):
            self.assertEqual(mg(1,3,8,2,0),5,'example 2')

        def test_ex3(self):
            self.assertEqual(mg(5),0,'example 3')

unittest.main()
