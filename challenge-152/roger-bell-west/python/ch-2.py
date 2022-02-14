#! /usr/bin/python3

import unittest

class Rect(object):
  
  def __init__(self,_xy1,_xy2):
    self.xy1=[min(_xy1[0],_xy2[0]),min(_xy1[1],_xy2[1])]
    self.xy2=[max(_xy1[0],_xy2[0]),max(_xy1[1],_xy2[1])]

  def area(self):
    area=1
    for axis in range(2):
      area *= self.xy2[axis]-self.xy1[axis]
    return area

  def overlap(self,other):
    area=1
    for axis in range(2):
      area *= max(0,
                  min(self.xy2[axis],other.xy2[axis])-
                  max(self.xy1[axis],other.xy1[axis]))
    return area
  
  def fullarea(self,other):
    return self.area()+other.area()-self.overlap(other)

class TestRect(unittest.TestCase):
        def test_ex1(self):
          self.assertEqual(Rect([-1,0],[2,2]).fullarea(Rect([0,-1],[4,4])),22,'example 1')

        def test_ex2(self):
          self.assertEqual(Rect([-3,-1],[1,3]).fullarea(Rect([-1,-3],[2,2])),25,'example 1')

unittest.main()
