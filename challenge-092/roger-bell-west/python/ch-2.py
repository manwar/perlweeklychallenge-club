#! /usr/bin/python3

def ii(iv,nv):
    q=iv
    q.append(nv)
    q.sort(key=lambda i: i[0])
    out=list()
    for il in q:
        if (len(out)==0 or
            out[len(out)-1][1] < il[0]):
            out.append(il)
        else:
            out[len(out)-1][1]=max(out[len(out)-1][1],il[1])
    return out

import unittest

class TestIi(unittest.TestCase):

    def test_ex1(self):
        self.assertEqual(ii([[1,4],[8,10]],[2,6]),[[1,6],[8,10]],'example 1')

    def test_ex2(self):
        self.assertEqual(ii([[1,2],[3,7],[8,10]],[5,8]),[[1,2],[3,10]],'example 2')

    def test_ex3(self):
        self.assertEqual(ii([[1,5],[7,9]],[10,11]),[[1,5],[7,9],[10,11]],'example 3')

    def test_ex4(self):
        self.assertEqual(ii([[7,9],[10,11]],[1,5]),[[1,5],[7,9],[10,11]],'example 4')

    def test_ex5(self):
        self.assertEqual(ii([[1,5],[10,11]],[7,9]),[[1,5],[7,9],[10,11]],'example 5')

unittest.main()
