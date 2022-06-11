#! /usr/bin/python3

import fileinput
import string
import random

f = dict()
r = dict()

for line in fileinput.input():
  line=line.rstrip()
  b = 1
  v = 0
  for l in string.ascii_lowercase:
    if l in line:
      v |= b
    b = b << 1
  if not v in r or len(r[v]) > len(line):
    f[line]=v
    r[v]=line
    
w = []
lt = (1 << 26) -1
lu = [0]
while lu[-1] != lt:
  wn = ""
  if len(w) > 0:
    mode = 0
    sc = []
    for wv in r.keys():
      if wv & lu[-1] == 0:
        if mode == 0:
          mode = 1
          sc = []
        sc.append(r[wv])
      elif mode == 0 and (wv | lu[-1]) != lu[-1]:
        sc.append(r[wv])
    if len(sc) == 0:
      w.pop()
      lu.pop()
    else:
      wn=random.choice(sc)
  else:
    wn=random.choice(list(f.keys()))
  if len(wn) > 0:
    w.append(wn)
    lu.append(lu[-1] | f[wn])

print(" ".join(w))
