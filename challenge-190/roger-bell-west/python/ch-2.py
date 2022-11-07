#! /usr/bin/python3

import unittest

from collections import deque

def decodedlist(s):
  stack = deque()
  stack.append([s])
  out = set()
  while True:
    ent = stack.popleft()
    tail = ent.pop()
    if len(tail) == 0:
      out.add(tuple(ent))
    else:
      if tail[0] != "0":
        q = ent.copy()
        q.append(tail[0])
        q.append(tail[1:])
        stack.append(q)
      if len(tail) >= 2:
        v = int(tail[0:2])
        if v >= 1 and v <= 26:
          q = ent.copy()
          q.append(tail[0:2])
          q.append(tail[2:])
          stack.append(q)
    if len(stack) == 0:
      break
  k = []
  alphazero = ord("A") - 1
  for x in out:
    k.append("".join(chr(int(cs)+alphazero) for cs in x))
  k.sort()
  return k

class TestDecodecounts(unittest.TestCase):
            
  def test_ex1(self):
    self.assertEqual(decodedlist("11"), ["AA", "K"], 'example 1')

  def test_ex2(self):
    self.assertEqual(decodedlist("1115"), ["AAAE", "AAO", "AKE", "KAE", "KO"], 'example 2')

  def test_ex3(self):
    self.assertEqual(decodedlist("127"), ["ABG", "LG"], 'example 3')

unittest.main()
