#! /usr/bin/python3

import fileinput

ml=0
r=list()
for line in fileinput.input():
  l=len(line)
  if l >= ml:
    line=line.rstrip()
    ll=list(line)
    if sorted(ll) == ll:
      if l > ml:
        r=list()
        ml=l
      r.append(line)

for l in r:
  print(l)
