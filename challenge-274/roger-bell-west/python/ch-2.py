#! /usr/bin/python3

def busroute(a):
  routes = []
  for rt in a:
    ri = dict()
    (interval, offset, duration) = rt
    start = offset
    while start <= 60 + offset:
      ri[start] = start + duration
      start += interval
    routes.append(ri)
  out = []
  for t in range(60):
    best = set()
    at = -1
    nxt = set()
    ndt = -1
    for i, r in enumerate(routes):
      nb = min([n for n in r.keys() if n >= t])
      nt = r[nb]
      if at == -1 or nt < at:
        best.clear()
        at = nt
      if nt <= at:
        best.add(i)
      if ndt == -1 or nb < ndt:
        nxt.clear()
        ndt = nb
      if nb <= ndt:
        nxt.add(i)
    if len(best.intersection(nxt)) == 0:
      out.append(t)
  return out
      

import unittest

class TestBusroute(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(busroute([[12, 11, 41], [15, 5, 35]]), [36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47], 'example 1')

  def test_ex2(self):
    self.assertEqual(busroute([[12, 3, 41], [15, 9, 35], [30, 5, 25]]), [0, 1, 2, 3, 25, 26, 27, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 55, 56, 57, 58, 59], 'example 2')

unittest.main()
