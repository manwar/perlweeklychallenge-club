#! /usr/bin/python3

def replacequestionmark(a):
  template = list(a)
  q = len([x for x in template if x == "?"])
  if q == 0:
    return [a]
  out = []
  for n in range(1 << q):
    qm = []
    nn = n
    while nn > 0:
      if nn % 2 == 1:
        qm.append("1")
      else:
        qm.append("0")
      nn //= 2
    while len(qm) < q:
      qm.append("0")
    entry = ""
    for tc in template:
      if tc == "?":
        entry += qm.pop()
      else:
        entry += tc
    out.append(entry)
  return out

import unittest

class TestReplacequestionmark(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(replacequestionmark("01??0"), ["01000", "01010", "01100", "01110"], 'example 1')

  def test_ex2(self):
    self.assertEqual(replacequestionmark("101"), ["101"], 'example 2')

  def test_ex3(self):
    self.assertEqual(replacequestionmark("???"), ["000", "001", "010", "011", "100", "101", "110", "111"], 'example 3')

  def test_ex4(self):
    self.assertEqual(replacequestionmark("1?10"), ["1010", "1110"], 'example 4')

  def test_ex5(self):
    self.assertEqual(replacequestionmark("1?1?0"), ["10100", "10110", "11100", "11110"], 'example 5')

unittest.main()
