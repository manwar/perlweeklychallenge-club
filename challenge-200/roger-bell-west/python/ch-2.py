#! /usr/bin/python3

def sevensegment(l):
  disp = [0x3f, 0x06, 0x5b, 0x4f, 0x66, 0x6d, 0x7d, 0x07, 0x7f, 0x67]
  v = []
  if l == 0:
    v = [0]
  else:
    ll = l
    while ll > 0:
      v.append(ll % 10)
      ll //= 10
    v.reverse()
  d = []
  for _r in range(7):
    d.append([" "] * (6 * len(v)))
  for (i, vv) in enumerate(v):
    x = 6 * i
    da = disp[vv]
    if da & 1 > 0:
      for xa in range(x + 1, x + 4):
        d[0][xa] = '#'
    if da & 2 > 0:
      for y in range(1, 3):
        d[y][x + 4] = '#'
    if da & 4 > 0:
      for y in range(4, 6):
        d[y][x + 4] = '#'
    if da & 8 > 0:
      for xa in range(x + 1, x + 4):
        d[6][xa] = '#'
    if da & 16 > 0:
      for y in range(4, 6):
        d[y][x] = '#'
    if da & 32 > 0:
      for y in range(1, 3):
        d[y][x] = '#'
    if da & 64 > 0:
      for xa in range(x + 1, x + 4):
        d[3][xa] = '#'
  for r in d:
    print("".join(r))

sevensegment(1234567890)
sevensegment(200)
