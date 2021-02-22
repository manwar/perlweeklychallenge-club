#! /usr/bin/python3

import math

def pas(aa):
    a=aa[::-1]
    n=len(a)
    f2=int(math.sqrt(n))
    f1=0
    while 1:
        if n % f2 == 0:
            f1=int(n/f2)
            break
        f2 -= 1
    out=list()
    for i in range(f2):
        out.append([0] * f1)
    x=-1
    y=0
    maxx=f1-1
    maxy=f2-1
    minx=0
    miny=1
    cnt=1
    while cnt:
        while x < maxx:
            x += 1
            out[y][x]=a.pop()
            if len(a)==0:
                cnt=0
                break
        maxx -= 1
        if cnt:
            while y < maxy:
                y += 1
                out[y][x]=a.pop()
                if len(a)==0:
                    cnt=0
                    break
            maxy -= 1
        if cnt:
            while x > minx:
                x -= 1
                out[y][x]=a.pop()
                if len(a)==0:
                    cnt=0
                    break
            minx += 1
        if cnt:
            while y > miny:
                y -= 1
                out[y][x]=a.pop()
                if len(a)==0:
                    cnt=0
                    break
            miny += 1
    return out

import unittest

class TestPas(unittest.TestCase):

        def test_ex1(self):
            self.assertEqual(pas([*range(1,4+1)]),[[1,2],[4,3]],'example 1')

        def test_ex2(self):
            self.assertEqual(pas([*range(1,6+1)]),[[1,2,3],[6,5,4]],'example 2')

        def test_ex3(self):
            self.assertEqual(pas([*range(1,12+1)]),[[1,2,3,4],[10,11,12,5],[9,8,7,6]],'example 3')

unittest.main()
