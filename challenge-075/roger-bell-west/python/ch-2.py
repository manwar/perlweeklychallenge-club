#! /usr/bin/python3

import unittest

def lrhist(c):
    bestarea=0
    n=[0,0]
    for a in range(len(c)-1):
        for b in range(a+1,len(c)):
            area=(b-a+1)*min(c[h] for h in range(a,b+1))
            if (area>bestarea):
                bestarea=area
                n=[a,b]
    return bestarea

class TestMajority(unittest.TestCase):

    def test_ex1(self):
        self.assertEqual(lrhist((2,1,4,5,3,7)),12,'example 1')

    def test_ex2(self):
        self.assertEqual(lrhist((3,2,3,5,7,5)),15,'example 2')

unittest.main()
