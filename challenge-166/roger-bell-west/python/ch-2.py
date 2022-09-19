#! /usr/bin/python3

from collections import defaultdict
import os

def kdd(dirlist0):
  dirlist = sorted(dirlist0)
  fx = defaultdict(set)
  for d in dirlist:
    for entry in os.scandir(d):
      nn = entry.name
      if entry.is_dir():
        nn += '/'
      fx[nn].add(d)
  mm = len(dirlist)
  out = [dirlist]
  for f in sorted(fx.keys()):
    if not len(fx[f]) == mm:
      l = []
      for d in dirlist:
        if d in fx[f]:
          l.append(f)
        else:
          l.append('')
      out.append(l)
  return out

def tabular(d):
  columnlength = []
  for row in d:
    for i,col in enumerate(row):
      while len(columnlength) <= i:
        columnlength.append(0)
      columnlength[i] = max([columnlength[i],len(col)])
  fs = " | ".join("{:<" + str(x) + "}" for x in columnlength)
  for row in d:
    print(fs.format(*row))

tabular(kdd(["dir_a","dir_b","dir_c"]))
