#! /usr/bin/python3

def pentagon(n):
  return int(n*(3*n-1)/2)

def pentpair():
  fpent=[0]
  rpent=dict()
  mx=0
  a=1
  while 1:
    while mx < a:
      mx += 1
      fpent.append(pentagon(mx))
      rpent[fpent[mx]]=mx
    for b in range(1,a):
      d=fpent[a]-fpent[b]
      if d < fpent[b]:
        break
      if d in rpent:
        s=fpent[a]+fpent[b]
        while s > fpent[mx]:
          mx += 1
          fpent.append(pentagon(mx))
          rpent[fpent[mx]]=mx
        if s in rpent:
          print("P({:d}) + P({:d}) = {:d} + {:d} = {:d} = P({:d})".format(
            a, b,
            fpent[a], fpent[b],
            s,
            rpent[s]))
          print("P({:d}) - P({:d}) = {:d} - {:d} = {:d} = P({:d})".format(
            a, b,
            fpent[a], fpent[b],
            d,
            rpent[d]))
          quit()
    a += 1
          

pentpair()
