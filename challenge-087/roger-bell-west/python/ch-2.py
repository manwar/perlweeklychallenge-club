#! /usr/bin/python3

def lr(s):
    maxx=len(s)-1
    maxy=len(s[0])-1
    maxa=0
    c=list()
    for x in range(0,maxx):
        for y in range(0,maxy):
            if (s[x][y]==1):
                for tx in range (x+1,maxx+1):
                    for ty in range (y+1,maxy+1):
                        valid=1
                        for sx in range(x,tx+1):
                            for sy in range(y,ty+1):
                                if (s[sx][sy]!=1):
                                    valid=0
                                    break
                            if (valid==0):
                                break
                        if (valid):
                            l=[tx-x+1,ty-y+1]
                            a=l[0]*l[1]
                            if (a > maxa):
                                maxa=a
                                c=l
    if (len(c)):
        o=list()
        for i in range(0,c[0]):
            o.append([1] * c[1])
        return o
    else:
        return 0
   
import unittest;

class TestLcs(unittest.TestCase):

    def test_ex1(self):
        self.assertEqual(lr((
            (0,0,0,1,0,0),
            (1,1,1,0,0,0),
            (0,0,1,0,0,1),
            (1,1,1,1,1,0),
            (1,1,1,1,1,0),
        )),
                         [
                             [1,1,1,1,1],
                             [1,1,1,1,1],
                         ],
                         'example 1')

    def test_ex2(self):
        self.assertEqual(lr((
            (1,0,1,0,1,0),
            (0,1,0,1,0,1),
            (1,0,1,0,1,0),
            (0,1,0,1,0,1),
        )),
                         0,
                         'example 2')

    def test_ex3(self):
        self.assertEqual(lr((
            (0,0,0,1,1,1),
            (1,1,1,1,1,1),
            (0,0,1,0,0,1),
            (0,0,1,1,1,1),
            (0,0,1,1,1,1),
        )),
                         [
                             [1,1,1,1],
                             [1,1,1,1],
                         ],
                         'example 3')

unittest.main()
