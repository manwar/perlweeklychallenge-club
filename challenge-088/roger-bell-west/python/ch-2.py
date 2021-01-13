#! /usr/bin/python3

def sm(m):
    mx=len(m)
    my=len(m[0])
    o=[m[0][0]]
    v=list()
    for i in range(mx):
        v.append([False] * my)
    dir=[
        [0,1],
        [1,0],
        [0,-1],
        [-1,0]
      ]
    x=0
    y=0
    d=0
    for i in range(mx*my-1):
        v[x][y]=True
        nx=int()
        ny=int()
        while (1):
            nx=x+dir[d][0]
            ny=y+dir[d][1]
            if (nx < 0 or
                nx >= mx or
                ny < 0 or
                ny >= my or
                v[nx][ny] == True):
                d=(d+1)%4
            else:
                break
        x=nx
        y=ny
        o.append(m[x][y])
    return o

import unittest;

class TestSm(unittest.TestCase):

    def test_ex1(self):
        self.assertEqual(sm((
            [ 1, 2, 3 ],
            [ 4, 5, 6 ],
            [ 7, 8, 9 ]
        )),[1, 2, 3, 6, 9, 8, 7, 4, 5],'example 1')

    def test_ex2(self):
        self.assertEqual(sm((
            [  1,  2,  3,  4 ],
            [  5,  6,  7,  8 ],
            [  9, 10, 11, 12 ],
            [ 13, 14, 15, 16 ]
        )),[1, 2, 3, 4, 8, 12, 16, 15, 14, 13, 9, 5, 6, 7, 11, 10],'example 2')

unittest.main()
