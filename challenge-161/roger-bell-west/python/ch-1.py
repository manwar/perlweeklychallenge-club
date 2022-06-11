#! /usr/bin/python3

import fileinput

from itertools import tee

b = []

for line in fileinput.input():
  line=line.rstrip()
  u = True
  j, k = tee(line)
  next(k,None)
  for i in zip(j,k):
    if i[0] > i[1]:
      u = False
      break
  if u:
    b.append(line)

b.sort(key=len,reverse=True)

for l in b:
  print(l)
