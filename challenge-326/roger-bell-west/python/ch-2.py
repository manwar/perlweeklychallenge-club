#! /usr/bin/python3

# by Ned Batchelder and Nadeen Ulhaq
# https://stackoverflow.com/a/312464
def chunks(lst, n):
    """Yield successive n-sized chunks from lst."""
    for i in range(0, len(lst), n):
        yield lst[i:i + n]

def decompressedlist(a):
  out = []
  for p in chunks(a, 2):
    out.extend([p[1]] * p[0])
  return out

import unittest

class TestDecompressedlist(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(decompressedlist([1, 3, 2, 4]), [3, 4, 4], 'example 1')

  def test_ex2(self):
    self.assertEqual(decompressedlist([1, 1, 2, 2]), [1, 2, 2], 'example 2')

  def test_ex3(self):
    self.assertEqual(decompressedlist([3, 1, 3, 2]), [1, 1, 1, 2, 2, 2], 'example 3')

unittest.main()
