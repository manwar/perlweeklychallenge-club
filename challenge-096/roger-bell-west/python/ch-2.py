#! /usr/bin/python3
import unittest

def ed(s,t):
    ss=list([0])
    for ch in s:
        ss.append(ch)
    tt=list([0])
    for ch in t:
        tt.append(ch)
    d=list()
    for i in range(len(ss)):
        d.append([0 for j in range (len(tt))])
    for i in range(1,len(ss)):
        d[i][0]=i
    for i in range(1,len(tt)):
        d[0][i]=i
    for j in range(1,len(tt)):
        for i in range(1,len(ss)):
            sc=0
            if (ss[i] != tt[j]):
                sc=1
            d[i][j]=min(
                d[i-1][j]+1,
                d[i][j-1]+1,
                d[i-1][j-1]+sc
                )
    return d[len(ss)-1][len(tt)-1]
    
class TestEd(unittest.TestCase):

    def test_ex1(self):
        self.assertEqual(ed('kitten','sitting'),3,'example 1')

    def test_ex2(self):
        self.assertEqual(ed('sunday','monday'),2,'example 2')

    def test_ex3(self):
        self.assertEqual(ed('branscombe','ranscombe'),1,'example 3')

unittest.main()
