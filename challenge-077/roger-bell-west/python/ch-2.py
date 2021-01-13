#! /usr/bin/python3

import unittest

def nx(n):
    mr=len(n)-1
    mc=len(n[0])-1
    isol=0
    for r in (range(0,mr+1)):
        for c in (range(0,mc+1)):
            if n[r][c] != 'X':
                continue
            isolated=1
            for dr in (-1,0,1):
                if (r+dr >= 0 and r+dr <= mr):
                    for dc in (-1,0,1):
                        if ((dc != 0 or dr != 0) and c+dc >= 0 and c+dc <= mc):
                            if n[r+dr][c+dc] == 'X':
                                isolated=0
                                break
            if (isolated):
                isol += 1
    return isol

class TestMajority(unittest.TestCase):

    def test_ex1(self):
        self.assertEqual(nx(('O O X'.split(),'X O O'.split(),'X O O'.split())),1,'example 1')

    def test_ex2(self):
        self.assertEqual(nx(('O O X O'.split(),'X O O O'.split(),'X O O X'.split(),'O X O O'.split())),2,'example 2')

unittest.main()
