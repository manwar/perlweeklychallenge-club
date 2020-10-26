#! /usr/bin/python3

import unittest

def fs(s):
    t=0
    maxx=len(s)-1
    maxy=len(s[0])-1
    for x in range(0,maxx):
        for y in range(0,maxy):
            if (s[x][y] == 1):
                for d in range(1,min(maxx-x,maxy-y)+1):
                    if (s[x+d][y] == 1 and
                        s[x][y+d] == 1 and
                        s[x+d][y+d] == 1):
                            t += 1
    return t

class TestFs(unittest.TestCase):

    def test_ex1(self):
        self.assertEqual(fs((
            [0,1,0,1],
            [0,0,1,0],
            [1,1,0,1],
            [1,0,0,1])),
                         1,'example 1')

    def test_ex2(self):
        self.assertEqual(fs((
            [1,1,0,1],
            [1,1,0,0],
            [0,1,1,1],
            [1,0,1,1])),
                         4,'example 2')

    def test_ex3(self):
        self.assertEqual(fs((
            [0,1,0,1],
            [1,0,1,0],
            [0,1,0,0],
            [1,0,0,1])),
                         0,'example 3')

unittest.main()
