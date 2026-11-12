#! /usr/bin/python3

def longestabsolutepath(fs):
  components = []
  maxlen = 0
  for entry in fs.split("\n"):
    parts = entry.split("\t")
    depth = len(parts)
    while len(components) < depth:
      components.append(0)
    while len(components) >= depth:
      components.pop()
    components.append(len(parts[-1]))
    if parts[-1].find(".") != -1:
      maxlen = max(maxlen, sum(components) + len(components) - 1)
  return maxlen

import unittest

class TestLongestabsolutepath(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(longestabsolutepath("dir\n\tsubdir1\n\t\tsubsubdir1\n\tsubdir2"), 0, 'example 1')

  def test_ex2(self):
    self.assertEqual(longestabsolutepath("file1.txt\nfile2.ext\na.png"), 9, 'example 2')

  def test_ex3(self):
    self.assertEqual(longestabsolutepath("my documents\n\tproject v1.0\n\t\tnotes v1.txt\n\timage.png"), 38, 'example 3')

  def test_ex4(self):
    self.assertEqual(longestabsolutepath("root\n\ta\n\t\tb\n\t\t\tc.txt\n\td\n\t\te.txt"), 14, 'example 4')

  def test_ex5(self):
    self.assertEqual(longestabsolutepath("a\n\tb\n\t\tc\n\t\t\td\n\t\t\t\te.txt\n\tvery_long_directory_name\n\t\tf.txt"), 32, 'example 5')

unittest.main()
