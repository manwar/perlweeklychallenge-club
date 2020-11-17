#! /usr/bin/python3

def lcs(n):
    l=list(n)
    l.sort(reverse=True)
    w=list()
    r=list()
    while (len(l)):
        n=l.pop()
        if (len(w)==0 or n==w[len(w)-1]+1):
            w.append(n)
        else:
            if (len(w) > len(r)):
                r=w
            w=[n]
    if (len(w) > len(r)):
        r=w
    if (len(r)>1):
        return r
    return 0
 
import unittest;

class TestLcs(unittest.TestCase):

    def test_ex1(self):
        self.assertEqual(lcs((100, 4, 50, 3, 2)),[2,3,4],'example 1')

    def test_ex2(self):
        self.assertEqual(lcs((20, 30, 10, 40, 50)),0,'example 2')

    def test_ex3(self):
        self.assertEqual(lcs((20, 19, 9, 11, 10)),[9,10,11],'example 3')

    def test_ex4(self):
        self.assertEqual(lcs((20, 19, 18, 11, 10)),[18,19,20],'example 4')

unittest.main()
