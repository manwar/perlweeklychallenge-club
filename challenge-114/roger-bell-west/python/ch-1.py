#! /usr/bin/python3

import unittest

def npn(n):
  nn=str(n)
  ii=""
  m=0
  l=len(nn)
  if l % 2 == 0:
    ii=nn[0:int(l/2)]
    m=1
  else:
    ii=nn[0:int((l+1)/2)]
    m=0
  i=int(ii)-1
  pn=0
  while pn <= n:
    ii=str(i)
    f=len(ii)
    i+=1
    if len(str(i)) > f:
      if m==0:
        m=1
        i=10**(f-1)
      else:
        m=0
        i=10**f
    ii=str(i)
    k=ii[::-1]
    if m==0:
      pns=ii + k[1:]
    else:
      pns=ii + k
    pn=int(pns)
  return pn

class TestNpn(unittest.TestCase):

        def test_ex1(self):
          self.assertEqual(npn(1234),1331,'example 1')
          
        def test_ex2(self):
          self.assertEqual(npn(999),1001,'example 2')
          

unittest.main()
