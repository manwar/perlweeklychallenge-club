#! /usr/bin/python3

class Reserve(object):
  def __init__(self, _vv):
    _vq = _vv
    _vq.sort()
    _vq.reverse()
    _vm = dict()
    for i, v in enumerate(_vq):
      _vm[v] = i
    self.values = _vq
    self.counts = [0] * len(_vv)
    self.vm = _vm

  def makechange(self, price, tendered):
    val = 0
    for bill in tendered:
      if bill not in self.vm:
        return False
      self.counts[self.vm.get(bill)] += 1
      val += bill
    val -= price
    for bid in range(len(self.values)):
      while val >= self.values[bid] and self.counts[bid] > 0:
        val -= self.values[bid]
        self.counts[bid] -= 1
    return (val == 0)

def exactchange(a):
  reserve = Reserve([5, 10, 20])
  for tendered in a:
    if not reserve.makechange(5, [tendered]):
      return False
  return True

import unittest

class TestExactchange(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(exactchange([5, 5, 5, 10, 20]), True, 'example 1')

  def test_ex2(self):
    self.assertEqual(exactchange([5, 5, 10, 10, 20]), False, 'example 2')

  def test_ex3(self):
    self.assertEqual(exactchange([5, 5, 5, 20]), True, 'example 3')

unittest.main()
