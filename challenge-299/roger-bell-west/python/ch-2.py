#! /usr/bin/python3

from collections import deque

def wordsearch(grid0, word):
  grid = dict()
  for y, row in enumerate(grid0):
    for x, c in enumerate(row):
      grid[(x, y)] = c
  for start, firstletter in grid.items():
    if firstletter == word[0]:
      queue = deque()
      queue.append([start])
      while len(queue) > 0:
        pos = queue.popleft()
        if len(pos) == len(word):
          return True
        else:
          for dir in ((0, 1), (1, 0), (0, -1), (-1, 0)):
            lpos = pos[-1]
            npos = (lpos[0] + dir[0], lpos[1] + dir[1])
            if npos in grid and npos not in pos and grid[npos] == word[len(pos)]:
              pp = pos.copy()
              pp.append(npos)
              queue.append(pp)
  return False
      

import unittest

class TestWordsearch(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(wordsearch([["A", "B", "D", "E"], ["C", "B", "C", "A"], ["B", "A", "A", "D"], ["D", "B", "B", "C"]], "BDCA"), True, 'example 1')

  def test_ex2(self):
    self.assertEqual(wordsearch([["A", "A", "B", "B"], ["C", "C", "B", "A"], ["C", "A", "A", "A"], ["B", "B", "B", "B"]], "ABAC"), False, 'example 2')

  def test_ex3(self):
    self.assertEqual(wordsearch([["B", "A", "B", "A"], ["C", "C", "C", "C"], ["A", "B", "A", "B"], ["B", "B", "A", "A"]], "CCCAA"), True, 'example 3')

unittest.main()
