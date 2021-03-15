#! /usr/bin/python3

def sip(n,t):
    if n[len(n)-1] < t:
        return len(n)
    l=0
    h=len(n)-1
    while (h-l > 1):
        m=int((h+l)/2)
        if n[m]==t:
            return m
        elif n[m] > t:
            h=m
        else:
            l=m
    if n[l] >= t:
        return l
    return h

import unittest

class TestSip(unittest.TestCase):

    def test_ex1(self):
        self.assertEqual(sip([1,2,3,4],3),2,'example 1')
    
    def test_ex2(self):
        self.assertEqual(sip([1,3,5,7],6),3,'example 2')
    
    def test_ex3(self):
        self.assertEqual(sip([12,14,16,18],10),0,'example 3')
    
    def test_ex4(self):
        self.assertEqual(sip([11,13,15,17],19),4,'example 4')

unittest.main()
