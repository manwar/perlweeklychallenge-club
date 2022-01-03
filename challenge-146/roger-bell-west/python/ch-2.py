#! /usr/bin/python3

import unittest
        
class Fraction(object):
    def __init__(self):
        self.n = 1
        self.d = 1

    def get_parent(self):
        p=Fraction()
        p.n = self.n
        p.d = self.d
        if p.n < p.d:
            p.d -= p.n
        else:
            p.n -= p.d
        return p

    def stringify(self):
        return str(self.n) + "/" + str(self.d)

    def set_from_string(self,s):
        q=s.split("/")
        self.n=int(q[0])
        self.d=int(q[1])
        return self

def p_gp(s):
    f=Fraction().set_from_string(s)
    out=[]
    for i in range(2):
        f=f.get_parent()
        out.append(f.stringify())
    return out
    
class TestP_Gp(unittest.TestCase):

        def test_ex1(self):
          self.assertEqual(p_gp("3/5"),["3/2","1/2"],'example 1')

        def test_ex2(self):
          self.assertEqual(p_gp("4/3"),["1/3","1/2"],'example 2')

unittest.main()
