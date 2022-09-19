#! /usr/bin/python3

import unittest

from math import sqrt

def isprime(candidate):
  if candidate < 2:
    return False
  elif candidate==2:
    return True
  elif candidate==3:
    return True
  elif candidate % 2 == 0:
    return False
  elif candidate % 3 == 0:
    return False
  anchor = 0
  limit = int(sqrt(candidate))
  while True:
    anchor += 6
    for t in range(anchor-1,anchor+2,2):
      if t > limit:
        return True
      if candidate % t == 0:
        return False

def ppc(ct):
  o = []
  fh = 0
  while len(o) < ct:
    fh += 1
    t = fh
    q = False
    while t > 0:
      if t % 10 == 0:
        q = True
        break
      t //= 10
    if q:
      continue
    sfh = str(fh)
    c = int(sfh + "0" + sfh[::-1])
    if isprime(c):
      o.append(c)
  return o

class TestPpc(unittest.TestCase):

        def test_ex1(self):
          self.assertEqual(ppc(20),
                           [101, 16061, 31013, 35053, 38083, 73037,
                            74047, 91019, 94049, 1120211, 1150511,
                            1160611, 1180811, 1190911, 1250521,
                            1280821, 1360631, 1390931, 1490941,
                            1520251],
                           'example 1')

unittest.main()
