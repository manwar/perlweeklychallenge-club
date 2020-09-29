#! /usr/bin/python3

import unittest

def cc(list):
    n=sorted(range(len(list)), key=lambda x: list[x])
    k=[0] * len(list)
    for i in n:
        nr=[1]
        if (i > 0 and list[i-1] < list[i]):
            nr.append(k[i-1]+1)
        if (i < len(list)-1 and list[i+1] < list[i]):
            nr.append(k[i+1]+1)
        k[i]=max(nr)
    return sum(k)

class TestCc(unittest.TestCase):

    def test_ex1(self):
        self.assertEqual(cc((1,2,2)),4,'example 1')

    def test_ex2(self):
        self.assertEqual(cc((1,4,3,2)),7,'example 2')

unittest.main()
