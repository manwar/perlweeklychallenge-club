#! /usr/bin/python3

import unittest
from collections import deque

def psum(n):
    pr=set(range(2,n+1))
    for m in range(2,n+1):
        for mi in range(2,n+1):
            pr.discard(m*mi)
    p=list(pr)
    p.sort(reverse=True)
    pi=dict()
    for i in range(0,len(p)):
        pi[p[i]]=i
    c=deque()
    o=list()
    while True:
        r=list()
        s=n
        if len(c)>0:
            r=c.popleft()
            s-=sum(p[i] for i in r)
        if (s>0):
            ru=set(r)
            ca=set(pi[i] for i in p if i<=s)
            ca-=ru
            for i in ca:
                q=r.copy()
                q.append(i)
                c.append(q)
        elif (s==0):
            o=[p[i] for i in r]
            break
    return len(o)

class TestMajority(unittest.TestCase):

    def test_ex(self):
        self.assertEqual(psum(9),2,'example')

unittest.main()
