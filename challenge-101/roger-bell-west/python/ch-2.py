#! /usr/bin/python3

import unittest

def ot(pp):
    points=pp
    points.append(points[0])
    xp=list()
    for i in range(3):
        xp.append(points[i][0] * (points[i+1][1]-points[i][1])
                  -points[i][1]*(points[i+1][0]-points[i][0]))
    xp.sort()
    if xp[0] <= 0 and xp[2] <= 0:
        return 1
    if xp[0] >= 0 and xp[2] >= 0:
        return 1
    return 0

class TestPas(unittest.TestCase):

        def test_ex1(self):
            self.assertEqual(ot([[0,1],[1,0],[2,2]]),0,'example 1')

        def test_ex2(self):
            self.assertEqual(ot([[1,1],[-1,1],[0,-3]]),1,'example 2')

        def test_ex3(self):
            self.assertEqual(ot([[0,1],[2,0],[-6,0]]),1,'example 3')

unittest.main()
