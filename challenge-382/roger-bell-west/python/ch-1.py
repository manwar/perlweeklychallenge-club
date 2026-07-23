#! /usr/bin/python3

from collections import defaultdict

def isqrt(s:int):
  if s <= 1:
    return s
  x0 = s // 2
  x1 = (x0 + s // x0) // 2
  while x1 < x0:
    x0 = x1
    x1 = (x0 + s // x0) // 2
  return x0

def is_adjacentsquared(param, hc):
  hcs = hc.copy()
  hcs.sort()
  if hcs != list(range(1, param + 1)):
    return False
  for i in range(param - 1):
    pn = hc[i] + hc[i + 1]
    sn = isqrt(pn)
    if pn != sn * sn:
      return False
  pn = hc[0] + hc[-1]
  sn = isqrt(pn)
  if pn != sn * sn:
    return False
  return True
    
def hamiltoniancycle(a):
  if a < 31:
    return []
  perfectsquares = set()
  lim = a * 2
  for p in range(1, a + 1):
    ps = p * p
    if ps > lim:
      break
    perfectsquares.add(ps)
  neighbours = defaultdict(lambda: set())
  for x in range(1, a + 1):
    for y in perfectsquares:
      if y > x:
        z = y - x
        if z <= a:
          neighbours[x].add(z)
          neighbours[z].add(x)
  stack = [[1]]
  while len(stack) > 0:
    lst = stack.pop()
    if len(lst) == a:
      if lst[0] + lst[-1] in perfectsquares:
        return lst
    else:
      for candidate in neighbours[lst[-1]]:
        if candidate not in lst:
          nlst = lst.copy()
          nlst.append(candidate)
          stack.append(nlst)
  return []

import unittest

class TestHamiltoniancycle(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(is_adjacentsquared(32, hamiltoniancycle(32)), True, 'example 1')

  def test_ex2(self):
    self.assertEqual(hamiltoniancycle(15), [], 'example 2')

  def test_ex3(self):
    self.assertEqual(is_adjacentsquared(34, hamiltoniancycle(34)), True, 'example 3')

unittest.main()
