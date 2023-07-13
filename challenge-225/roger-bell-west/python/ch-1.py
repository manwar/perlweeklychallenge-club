#! /usr/bin/python3

def maxwords(a):
  return 1 + max([l.count(" ") for l in a])

import unittest

class TestMaxwords(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(maxwords(["Perl and Raku belong to the same family.", "I love Perl.", "The Perl and Raku Conference."]), 8, 'example 1')

  def test_ex2(self):
    self.assertEqual(maxwords(["The Weekly Challenge.", "Python is the most popular guest language.", "Team PWC has over 300 members."]), 7, 'example 2')

unittest.main()
