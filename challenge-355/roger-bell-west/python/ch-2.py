#! /usr/bin/python3

from itertools import islice
import collections

# https://docs.python.org/3/library/itertools.html
def sliding_window(iterable, n):
    # sliding_window('ABCDEFG', 4) --> ABCD BCDE CDEF DEFG
    it = iter(iterable)
    window = collections.deque(islice(it, n), maxlen=n)
    if len(window) == n:
        yield tuple(window)
    for x in it:
        window.append(x)
        yield tuple(window)


def mountainarray(a):
  state = 0
  for b in sliding_window(a, 2):
    if b[1] > b[0]:
      match state:
        case 0 | 1:
          state = 1
        case _:
          return False
    elif b[1] < b[0]:
      match state:
        case 1 | 2:
          state = 2
        case _:
          return False
    else:
      return False
  return state == 2
        
import unittest

class TestMountainarray(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(mountainarray([1, 2, 3, 4, 5]), False, 'example 1')

  def test_ex2(self):
    self.assertEqual(mountainarray([0, 2, 4, 6, 4, 2, 0]), True, 'example 2')

  def test_ex3(self):
    self.assertEqual(mountainarray([5, 4, 3, 2, 1]), False, 'example 3')

  def test_ex4(self):
    self.assertEqual(mountainarray([1, 3, 5, 5, 4, 2]), False, 'example 4')

  def test_ex5(self):
    self.assertEqual(mountainarray([1, 3, 2]), True, 'example 5')

unittest.main()
