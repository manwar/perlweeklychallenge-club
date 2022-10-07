#! /usr/bin/python3

import unittest

def recomposemaskcode(lst):
  out = []
  for ins in lst:
    count = 0
    os = ""
    for c in ins:
      if (c >= "0" and c <= "9") or (c >= "a" and c <= "z"):
        if count < 4:
          count += 1
          os += "x"
        else:
          os += c
      else:
        os += c
    out.append(os)
  return out

class TestRecomposemaskcode(unittest.TestCase):

        def test_ex1(self):
          self.assertEqual(recomposemaskcode(["ab-cde-123", "123.abc.420", "3abc-0010.xy"]),
                           ["xx-xxe-123", "xxx.xbc.420", "xxxx-0010.xy"],
                           'example 1')

        def test_ex2(self):
          self.assertEqual(recomposemaskcode(["1234567.a", "a-1234-bc", "a.b.c.d.e.f"]),
                           ["xxxx567.a", "x-xxx4-bc", "x.x.x.x.e.f"],
                           'example 2')

unittest.main()
