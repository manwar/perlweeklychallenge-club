#!/usr/bin/python

print "ch-1.py, PWC #43 Task #1: Olympic rings."

def numbers():
  start = 0
  end   = 8
  while start <= end:
    i = start
    start += 2

    if i == 0  : win = [0,a[i],a[i+1]]
    elif i == 8: win = [a[i-1],a[i],0]
    else       : win = [a[i-1],a[i],a[i+1]]

    nr = win.count("x")
    if nr == 1:
      if win[1] == 'x': a[i] = 11 - win[0] - win[2] 
      elif win[0] == 'x': a[i-1] = 11 - win[1] - win[2]
      elif win[2] == 'x': a[i+1] = 11 - win[1] - win[0]

# ---------------- MAIN -------------------

a = [9,"x",5,'x','x','x',7,'x',8]
print "Values: ", a

while True:
  numbers()
  nrx = a.count("x")
  if nrx == 0: break

print "Result: ", a

