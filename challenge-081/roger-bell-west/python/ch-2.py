#! /usr/bin/python3

import fileinput
from itertools import chain

c=dict()

for line in fileinput.input():
    line=line.rstrip("\r\n")
    for rep in ('--',"'s",'.','"','(',')',','):
        line=line.replace(rep,' ')
    for word in line.split():
        c.setdefault(word,0)
        c[word] += 1

f=dict()
for w in sorted(c.keys()):
    f.setdefault(c[w],list())
    f[c[w]].append(w)

for n in sorted(f.keys()):
    print(' '.join((list(str(n)) + f[n])))
    print('')
