#! /usr/bin/python3

import unittest
import re

def seob(n):
  return ((n & 0x55)<<1) | ((n & 0xAA)>>1)

class TestSeob(unittest.TestCase):

        def test_ex1(self):
          self.assertEqual(seob(101),154,'example 1')
          
        def test_ex2(self):
          self.assertEqual(seob(18),33,'example 2')

unittest.main()
