#! /usr/bin/python3

import unittest

def bell(count):
    a=[[1]]
    for row in range(1,count):
        b=[a[-1][-1]]
        for col in range(1,row+1):
            b.append(b[col-1]+a[-1][col-1])
        a.append(b)
    return [i[0] for i in a]

class TestBell(unittest.TestCase):

        def test_ex1(self):
            self.assertEqual(bell(10),[1, 1, 2, 5, 15, 52, 203, 877, 4140, 21147],'example 1')

unittest.main()
