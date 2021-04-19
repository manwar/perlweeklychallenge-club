#! /usr/bin/python3

import unittest

def chowla(count):
    a=[]
    for n in range(1,count+1):
        s=0
        for i in range(2,n):
            if n % i == 0:
                s += i
        a.append(s)
    return a

class TestChowla(unittest.TestCase):

        def test_ex1(self):
            self.assertEqual(chowla(20),[0, 0, 0, 2, 0, 5, 0, 6, 3, 7, 0, 15, 0, 9, 8, 14, 0, 20, 0, 21],'example 1')

unittest.main()
