#! /usr/bin/python3

t = dict()

fh = open('temperature.txt','r')
for ll in fh:
  line = ll.rstrip()
  l = line.split(",")
  t[l[0].strip()] = int(l[1].strip())

lt = 999
for k in sorted(t.keys()):
  if t[k] > lt:
    print(k)
  lt = t[k]
