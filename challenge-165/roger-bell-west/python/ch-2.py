#! /usr/bin/python3

import fileinput

from itertools import combinations

def median(s0):
  s = s0
  s.sort()
  return s[int(len(s)/2)]

points = []

for line in fileinput.input():
  line=line.rstrip()
  for pp in line.split(' '):
    if len(pp) > 0:
      print(pp)
      points.append([int(i) for i in pp.split(',')])

slope = []
for p in combinations(points,2):
  if p[0][0] != p[1][0]:
    slope.append((p[1][1]-p[0][1])/(p[1][0]-p[0][0]))

m = median(slope)
c = median([p[1] - m*p[0] for p in points])
x = [p[0] for p in points]
l = []

for xb in [min(x),max(x)]:
  l.append(xb)
  l.append(xb * m + c)

print(",".join(str(i) for i in l))
