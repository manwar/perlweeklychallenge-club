#! /usr/bin/python3

import unittest

from random import randint
import multiprocessing as mp
from time import sleep

def sleeper(x,q):
  sleep(float(x)/500.0)
  q.put(x)

def sleepsort(n):
  q=mp.SimpleQueue()
  pq=[]
  for i in n:
    p=mp.Process(target=sleeper,args=(i,q))
    p.start()
    pq.append(p)
  for p in pq:
    p.join()
  r=[]
  while not q.empty():
    r.append(q.get())
  return r

class TestSleepsort(unittest.TestCase):

        def test_ex1(self):
          a=[]
          for i in range(10):
            a.append(randint(1,100))
          self.assertEqual(sleepsort(a),sorted(a),'example 1')

unittest.main()
