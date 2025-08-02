#!/usr/bin/env -S nim r -d:release --verbosity:0 --hints:off
import math, algorithm

var
  mem: seq[int]
  ti: range[0..2] = 0

proc regNum(t: array[3, int]) =
  let num = (2 ^ t[0]) * (3 ^ t[1]) * (5 ^ t[2])

  if num notin mem:
    mem.add num

for i in 0..9:
  for j in 0..i:
    for k in j..i:
      var t = [j, k, i]
      if i == 4: echo (j, k),t
      regnum(t)
      while t.nextPermutation():
        regnum(t)
      t.sort()

mem.sort()
for i, v in mem:
  echo i+1, ": ", v
