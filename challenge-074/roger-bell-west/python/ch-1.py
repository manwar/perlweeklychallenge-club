#! /usr/bin/python3

import unittest

def majority(list):
    s=dict()
    for x in list:
        s.setdefault(x,0)
        s[x] += 1
    m=max(s.values())
    if m > int(len(list)/2):
        q=dict()
        for x in s.keys():
            q[s[x]]=x
        return q[m]
    else:
        return -1

class TestMajority(unittest.TestCase):

    def test_ex1(self):
        self.assertEqual(majority((1, 2, 2, 3, 2, 4, 2)),2,'example 1')

    def test_ex2(self):
        self.assertEqual(majority((1, 3, 1, 2, 4, 5)),-1,'example 2')

unittest.main()
