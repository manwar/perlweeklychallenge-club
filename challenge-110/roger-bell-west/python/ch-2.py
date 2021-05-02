#! /usr/bin/python

import fileinput

a=[]

for line in fileinput.input():
    line=line.rstrip()
    r=line.split(',')
    for ci in range(len(r)):
        while len(a) < ci+1:
            a.append([])
        a[ci].append(r[ci])

for r in a:
          print (','.join(r))
