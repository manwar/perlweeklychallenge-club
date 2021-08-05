#! /usr/bin/python3

from itertools import combinations

def tow(n):
    target=int(sum(n)/2)
    k=int(len(n)/2)
    bestval=-1
    bestset=[]
    for set in combinations(n,k):
        l=abs(target-sum(set))
        if bestval < 0 or l < bestval:
            bestval=l
            bestset=set
    o=[[],[]]
    r=dict()
    for i in bestset:
        r[i]=1
    for m in n:
        if m in r:
            o[1].append(m)
        else:
            o[0].append(m)
    for i in range(2):
        print("(" + ", ".join([str(j) for j in o[i]]) + ")")


tow([10, 20, 30, 40, 50, 60, 70, 80, 90, 100])
print("")

tow([10, -15, 20, 30, -25, 0, 5, 40, -5])
