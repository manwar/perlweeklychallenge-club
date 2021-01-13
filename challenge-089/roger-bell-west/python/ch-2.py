#! /usr/bin/python3
 
def ms(order,start,inc):
    m=list()
    for i in range(order):
        m.append([0] * order)
    x=int(order/2)+1
    y=int(order/2)
    n=start
    while 1:
        m[x][y]=n
        n+=inc
        xa=(x+1) % order
        ya=(y+1) % order
        if (m[xa][ya]>0):
            xa=(x+2) % order
            ya=y
            if (m[xa][ya]>0):
                break
        x=xa
        y=ya
    return m
            
import unittest

class TestMs(unittest.TestCase):

    def setUp(self):
        self.ms=ms(3,1,1)
    
    def test_ex1(self):
        self.assertEqual(sum(self.ms[0]),15,'row 1')

    def test_ex2(self):
        self.assertEqual(sum(self.ms[1]),15,'row 2')

    def test_ex3(self):
        self.assertEqual(sum(self.ms[2]),15,'row 3')
    
    def test_ex4(self):
        self.assertEqual(sum(x[0] for x in self.ms),15,'col 1')
    
    def test_ex5(self):
        self.assertEqual(sum(x[1] for x in self.ms),15,'col 2')
    
    def test_ex6(self):
        self.assertEqual(sum(x[2] for x in self.ms),15,'col 3')
    
    def test_ex7(self):
        self.assertEqual(sum(self.ms[x][x] for x in range(3)),15,'dia 1')
    
    def test_ex8(self):
        self.assertEqual(sum(self.ms[x][2-x] for x in range(3)),15,'dia 2')

unittest.main()
