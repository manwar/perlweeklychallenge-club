#! /usr/bin/python3

def hcs(n):
    s=list()
    t=list()
    while 1:
        s=list()
        l=0
        if len(t)>0:
            s=t.pop()
            l=sum((0 if i==1 else len(str(i)))+1 for i in s)
        if l==n:
            break
        if l > n:
            continue
        c=l
        while 1:
            tt=(0 if c==1 else len(str(c)))+l+1
            if c==tt:
                k=s.copy()
                k.append(c)
                t.append(k)
            if c > tt:
                break
            c+=1
    return ''.join((("" if i==1 else str(i)) + "#") for i in s)


import unittest

class TestHcs(unittest.TestCase):

        def test_ex1(self):
            self.assertEqual(hcs(1),'#','example 1')

        def test_ex2(self):
            self.assertEqual(hcs(2),'2#','example 2')

        def test_ex3(self):
            self.assertEqual(hcs(3),'#3#','example 3')

        def test_ex4(self):
            self.assertEqual(hcs(10),'#3#5#7#10#','example 4')

        def test_ex5(self):
            self.assertEqual(hcs(14),'2#4#6#8#11#14#','example 5')

unittest.main()
